from django.http import response
from Apps.Membership.models import SessionUser
from rest_framework.decorators import api_view
from rest_framework.response import Response


import stripe

from datetime import datetime

stripe.api_key = "sk_test_51IVaTrCRUp8Jfn8foA5gnvdrrYy8wy2hqemRpXhq6yeBtOq5WC3cbcGvGEZKkmtisCFs9YiCpfyZ1wm3aMpYVg9J00juk3Z83D"


@api_view(['GET', ])
def success(request):
    if 'sessionId' in request.GET:
        exam = request.GET['exam']
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
        
        user.premiumExams.append(exam)
        
        user.save()
    
    return response.HttpResponse("<h1>Payment SuccessFul. Enjoy your membership. You can return to SmartPrep App now.</h1>")


@api_view(['GET', ])
def cancel(request):
    return response.HttpResponse("<h1> Payment Cancelled </h1>")

@api_view(['GET', ])
def checkout(request):
    try:
        amount = request.GET['amount']
        exam = request.GET['exam']

        membership30ID = 'price_1JYZpCCRUp8Jfn8fqJTxE223'
        membership50ID = 'price_1JYZpCCRUp8Jfn8fqJTxE223'
        membership100ID = 'price_1JYZpCCRUp8Jfn8fqJTxE223'

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
            success_url='https://smartprep-app.herokuapp.com/payments/success?sessionId={CHECKOUT_SESSION_ID}&exam={exam}',
            cancel_url='https://smartprep-app.herokuapp.com/payments/cancel',
        )

        newSession = SessionUser(user = request.user, sessionID = session.id)
        newSession.save()

        print(session.url)


        return Response(session.url)

    except:
        return Response("Oops")
