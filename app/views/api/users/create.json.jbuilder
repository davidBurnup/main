
if @user.errors.present?
  json.errors do
    @user.errors.messages.each do |input, message|
      json.set! input, message[0]
    end
  end
else
  json.partial! 'user', user: @user
end
