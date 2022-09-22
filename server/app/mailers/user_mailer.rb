class UserMailer < ActionMailer::Base
    default :from => "squealer@sparta.herokuapp.com"
    
    def report(user, relation, msg)
        @user = user
        @relation = relation
        @msg = msg
        mail(
            to: "ryan@ryangomba.com",
            subject: "Uh oh!"
        )
    end
    
end
