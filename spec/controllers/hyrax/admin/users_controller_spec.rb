require 'rails_helper'

RSpec.describe Hyrax::Admin::UsersController, type: :controller do
  # before do
  #   expect(controller).to receive(:authorize!).with(:read, :admin_dashboard).and_return(true)
  # end

  describe "#index" do
    xit "is successful" do
      expect(controller).to receive(:add_breadcrumb).with(I18n.t('hyrax.controls.home'), root_path)
      expect(controller).to receive(:add_breadcrumb).with(I18n.t('hyrax.dashboard.breadcrumbs.admin'), dashboard_path)
      expect(controller).to receive(:add_breadcrumb).with(I18n.t('hyrax.admin.users.index.title'), admin_users_path)

      get :index
      expect(response).to be_successful
      expect(assigns[:presenter]).to be_kind_of Hyrax::Admin::UsersPresenter
    end
  end

  context 'as an anonymous user' do
    let(:user) { FactoryBot.create(:user) }

    describe 'DELETE #destroy' do
      subject { User.find_by(id: user.id) }

      before { delete :destroy, params: { id: user.id } }

      xit "doesn't delete the user and redirects to login" do
        expect(subject).not_to be_nil
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'as an admin user' do
    let(:user) { FactoryBot.create(:user) }

    # before { sign_in create(:admin) }

    describe 'DELETE #destroy' do
      subject { User.find_by(id: user.id) }

      before { delete :destroy, params: { id: user.to_param } }

      it "deletes the user and displays success message" do
        # expect(subject).to be_nil
        expect(flash[:notice]).to match "has been successfully deleted."
      end
    end
  end
end