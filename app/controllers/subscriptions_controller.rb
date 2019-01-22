class SubscriptionsController < ApplicationController

    layout "subscribe"
    before_action :authenticate_user!, except: [:new, :create]

    def new

    end

    def create
        Stripe.api_key = Rails.application.credentials.stripe_api_key

        plan_id = params[:plan_id]
        plan = Stripe::Plan.retrieve(plan_id)

        token = params[:stripeToken]

        customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)

            else
                Stripe::Customer.create({email: current_user.email, source:token, 
                    shipping: {
                        address: {
                            city: 'Wellington',
                            line1: 'something address'
                        },
                        name: "customer name"
                    }
                })
            end
        
        subscription = customer.subscriptions.create({plan: plan.id,
            metadata: {0=>'M', 1=>'Rosé', 2=>'Pomegranate', 3=>'Navy&Merlot', 4=>'Navy&Khaki', 5=>'Black', 6=>'Grey&Black'}
        })

        redirect_to root_path, notice: "Your subscription was set up successfully."

    end
end