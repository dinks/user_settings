require 'spec_helper'
require 'json'

describe UserSettingsController do

  context 'with no current user' do

    before do
      ApplicationController.any_instance.stub(:set_current_user) { true }
    end

    context 'for get key' do
      before { get :show, key: :test, format: :json }

      it 'returns failure' do
        response.should_not be_success
      end

    end

    context 'for set key' do
      before { post :create, key: :test, value: :test, format: :json }

      it 'returns failure' do
        response.should_not be_success
      end

    end

    context 'for set once key' do
      before { put :create_once, key: :test, value: :test, format: :json }

      it 'returns failure' do
        response.should_not be_success
      end

    end

    context 'for delete key' do
      before { delete :destroy, key: :test, format: :json }

      it 'returns failure' do
        response.should_not be_success
      end

    end

  end

  context 'with current user' do

    let(:value) { 'test_value' }

    context 'for get key' do
      context 'when no value exists' do
        before { get :show, key: :test, format: :json }

        it 'returns success' do
          response.should be_success
        end

        it 'should not find the key' do
          parsed_body = JSON.parse(response.body)
          parsed_body['success'].should == false
        end
      end

      context 'when a value exists' do
        before do
          UserSettings::Key.stub(:find) { value }
          get :show, key: :test, format: :json
        end

        it 'returns success' do
          response.should be_success
        end

        it 'should find the key' do
          parsed_body = JSON.parse(response.body)
          parsed_body['value'].should == value
        end
      end
    end

    context 'for set key' do

      before do
        UserSettings::Key.stub(:create_or_update) { 'OK' }
      end

      context 'when no value exists' do
        before do
          UserSettings::Key.stub(:find) { false }
          post :create, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          response.should be_success
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          parsed_body['success'].should == true
        end
      end

      context 'when value exists' do
        before do
          UserSettings::Key.stub(:find) { true }
          post :create, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          response.should be_success
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          parsed_body['success'].should == true
        end
      end

    end

    context 'for set once key' do

      before do
        UserSettings::Key.stub(:create_or_update) { 'OK' }
      end

      context 'when no value exists' do
        before do
          UserSettings::Key.stub(:find) { false }
          put :create_once, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          response.should be_success
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          parsed_body['success'].should == true
        end
      end

      context 'when value exists' do
        before do
          UserSettings::Key.stub(:find) { true }
          put :create_once, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          response.should be_success
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          parsed_body['success'].should == false
        end
      end
    end

    context 'for delete key' do
      before { delete :destroy, key: :test, format: :json }

      it 'returns success' do
        response.should be_success
      end

    end
  end
end
