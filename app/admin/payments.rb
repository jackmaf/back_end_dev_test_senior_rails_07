ActiveAdmin.register Payment do
  controller do
    before_action :protected_attributes
    def protected_attributes
      params.permit!
    end
  end
end
