from django.http import response
from rest_framework.views import APIView
from Apps.Membership.models import SessionUser
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
import os
from Apps.Questions.models import DailyQuestions

# Created new web app "smartprep": https://smartprep.azurewebsites.net

import stripe

from datetime import datetime

stripe.api_key = os.getenv("STRIPE_API_KEY")


# @api_view(['GET', ])
# def success(request):
#     if 'sessionId' in request.GET:
#         exam = request.GET['exam']
#         print(exam)
#         session = stripe.checkout.Session.retrieve(request.GET['sessionId'],)
#         print(session.amount_subtotal)
#         user = SessionUser.objects.get(sessionID = request.GET['sessionId']).user
#         user.stripeId = session.customer
#         user.membershipEnd = datetime.now()
#         user.stripeSubscriptionId = session.subscription

#         if session.amount_subtotal == 3000:
#             user.membershipOf30 = True
#         elif session.amount_subtotal == 5000:
#             user.membershipOf50 = True
#         else:
#             user.membershipOf100 = True

#         user.save()
        
#         user.premiumExams.append('{}'.format(exam))
        
#         user.save()

#         todaysDailyQuestion = DailyQuestions.objects.filter(user=user, exam=exam)

#         if todaysDailyQuestion:
#             todaysDailyQuestion.delete()
    
#     return response.HttpResponse("<h1>Payment SuccessFul. Enjoy your membership. You can return to SmartPrep App now.</h1>")



# @api_view(['GET', ])
# def checkout(request):
#     try:
#         amount = request.GET['amount']
#         exam = request.GET['exam']

#         SERVER_URL = os.getenv("SERVER_URL")

#         testPlan = 'price_1KEtv3CRUp8Jfn8fxaqA9xWG'
        
#         session = stripe.checkout.Session.create(
#             payment_method_types=['card'],
#             line_items=[{
#                 'price': testPlan,
#                 'quantity': 1,
#             }],
#             mode='subscription',
#             allow_promotion_codes=True,
#             success_url=SERVER_URL+'payments/success?sessionId={CHECKOUT_SESSION_ID}&exam='+exam,
#             cancel_url=SERVER_URL+'payments/cancel',
#         )

#         newSession = SessionUser(user = request.user, sessionID = session.id)
#         newSession.save()

#         return Response(session.url)

#     except:
#         return Response("Oops")






@api_view(['GET', ])
def checkout(request):
    try:
        amount = request.GET['amount']
        exam = request.GET['exam']

        SERVER_URL = int(os.getenv("SERVER_URL"))

        membership30ID = 'price_1KFJ0dCRUp8Jfn8fpHdBR0Ge'
        membership50ID = 'price_1KFJ4TCRUp8Jfn8fsgSwOn5W'
        membership100ID = 'price_1KFJ5vCRUp8Jfn8fFe2EMzMt'

        # Create Stripe Checkout
        
        if amount == 30:
            membershipID = membership30ID
        elif amount == 50:
            membershipID = membership50ID
        else:
            membershipID = membership100ID
        
        session = stripe.checkout.Session.create(
            payment_method_types=['card'],
            customer_email = request.user.email,
            line_items=[{
                'price': membershipID,
                'quantity': 1,
            }],
            mode='subscription',
            allow_promotion_codes=True,
            success_url=SERVER_URL+'payments/success?sessionId={CHECKOUT_SESSION_ID}&exam='+exam,
            cancel_url=SERVER_URL+'payments/cancel',
        )

        newSession = SessionUser(user = request.user, sessionID = session.id)
        newSession.save()

        return Response(session.url)

    except:
        return Response("Oops")




class PaymentSuccess(APIView):
    permission_classes = [AllowAny]

    def get(self, request):
        if 'sessionId' in request.GET:
            exam = request.GET['exam']
            print(exam)
            session = stripe.checkout.Session.retrieve(request.GET['sessionId'],)
            print(session.amount_subtotal)
            user = SessionUser.objects.get(sessionID = request.GET['sessionId']).user
            user.stripeId = session.customer
            user.membershipEnd = datetime.now()
            user.stripeSubscriptionId = session.subscription

            if session.amount_subtotal == 3000:
                user.membershipOf30 = True
            elif session.amount_subtotal == 5000:
                user.membershipOf50 = True
            else:
                user.membershipOf100 = True

            user.save()

            alreadyAddedPremiumExams = str(user.premiumExams).split(", ")
            
            alreadyAddedPremiumExams.append(', {}'.format(exam))

            user.premiumExams = ", ".join(alreadyAddedPremiumExams)
            
            user.save()

            todaysDailyQuestion = DailyQuestions.objects.filter(user=user, exam=exam)

            if todaysDailyQuestion:
                todaysDailyQuestion.delete()
        else:
            return Response("There is an error in your payment. Contact Smartprep Support Team if money has detected from your account.")
    
        return response.HttpResponse("<h1>Your Payment is SuccessFul. \n\n Enjoy your membership. \n\nYou can return to SmartPrep App now.</h1>")



class CancelPayment(APIView):
    permission_classes = [AllowAny]

    def get(self, request):
        return response.HttpResponse("<h1> Payment Cancelled </h1>")


# OpenSource$403