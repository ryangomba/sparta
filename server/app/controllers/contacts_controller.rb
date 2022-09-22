class ContactsController < ApplicationController
    
    def create
        #puts params.inspect
        @user = User.find_or_create_by_device_id(params[:user_email]) if params[:user_email]
        @user = User.find_or_create_by_device_id(params[:device_id]) if @user.nil?
        params[:contacts].each do |c|
            if Contact.find_by_uid(c[:uid]).nil?
                me = c.delete(:me)
                c[:family] = Contact.family_member?(c[:nickname])
                if c[:family] == true then puts 'FAMILY MEMBER!' end
                contact = @user.contacts.create(c)
                if me == true
                    @user.contact_id = contact.id
                    @user.save
                end
            end
        end
        render :nothing => true
    end

end
