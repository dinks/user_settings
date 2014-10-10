require 'spec_helper'
require 'json'

describe UserSettingsController, type: :controller do

  context 'with no current user' do

    before do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(true)
    end

    context 'for get key' do
      before { get :show, key: :test, format: :json }

      it 'returns failure' do
        expect(response.status).to eq(401)
      end
    end

    context 'for set key' do
      before { post :create, key: :test, value: :test, format: :json }

      it 'returns failure' do
        expect(response.status).to eq(401)
      end
    end

    context 'for set once key' do
      before { put :create_once, key: :test, value: :test, format: :json }

      it 'returns failure' do
        expect(response.status).to eq(401)
      end
    end

    context 'for delete key' do
      before { delete :destroy, key: :test, format: :json }

      it 'returns failure' do
        expect(response.status).to eq(401)
      end
    end

  end

  context 'with current user' do

    let(:value) { 'test_value' }

    context 'for get key' do
      context 'when no value exists' do
        before { get :show, key: :test, format: :json }

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should not find the key' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['success']).to eql(false)
        end
      end

      context 'when a value exists' do
        before do
          allow(UserSettings::Key).to receive(:find).and_return(value)
          get :show, key: :test, format: :json
        end

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should find the key' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['value']).to eql(value)
        end
      end
    end

    context 'for set key' do
      before do
        allow(UserSettings::Key).to receive(:create_or_update).and_return('OK')
      end

      context 'when no value exists' do
        before do
          allow(UserSettings::Key).to receive(:find).and_return(false)
          post :create, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['success']).to eql(true)
        end
      end

      context 'when value exists' do
        before do
          allow(UserSettings::Key).to receive(:find).and_return(true)
          post :create, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['success']).to eql(true)
        end
      end
    end

    context 'for set once key' do
      before do
        allow(UserSettings::Key).to receive(:create_or_update).and_return('OK')
      end

      context 'when no value exists' do
        before do
          allow(UserSettings::Key).to receive(:find).and_return(false)
          put :create_once, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['success']).to eql(true)
        end
      end

      context 'when value exists' do
        before do
          allow(UserSettings::Key).to receive(:find).and_return(true)
          put :create_once, key: :test, value: :test, format: :json
        end

        it 'returns success' do
          expect(response.status).to eq(200)
        end

        it 'should have success in json' do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['success']).to eql(false)
        end
      end
    end

    context 'for delete key' do
      before { delete :destroy, key: :test, format: :json }

      it 'returns success' do
        expect(response.status).to eq(200)
      end

    end
  end
end
