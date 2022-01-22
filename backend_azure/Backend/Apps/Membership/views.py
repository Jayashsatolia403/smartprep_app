from django.http import response
from django.shortcuts import redirect, render
from rest_framework.views import APIView
from Apps.Membership.models import SessionUser
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
import os
from Apps.Questions.models import DailyQuestions



import stripe
from update_db_file import update_database_file

from datetime import datetime
from django.contrib.auth.decorators import login_required



stripe.api_key = os.getenv("STRIPE_API_KEY")




@login_required
def payments_page(request):

    if request.method == 'POST':

        amount = int(request.GET['amount'])
        exam = request.POST['exam']

        SERVER_URL = os.getenv("SERVER_URL")

        membership30ID = os.getenv("membership30ID")
        membership50ID = os.getenv("membership50ID")
        membership100ID = os.getenv("membership100ID")

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

        update_database_file()

        return redirect(session.url)
    
    return render(request, "payments.html")



class PaymentsPage(APIView):
    permission_classes = [AllowAny]

    def get(self, request):
        return Response(os.getenv("SERVER_URL") + "payments")






@api_view(['GET', ])
def checkout(request):
    try:
        amount = int(request.GET['amount'])
        exam = request.GET['exam']

        SERVER_URL = os.getenv("SERVER_URL")

        membership30ID = os.getenv("membership30ID")
        membership50ID = os.getenv("membership50ID")
        membership100ID = os.getenv("membership100ID")

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

        update_database_file()

        return Response(session.url)

    except Exception as e:
        print(e)
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

            update_database_file()

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

