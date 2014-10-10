require 'spec_helper'

describe 'Routes', type: :routing do
  context 'with default routes' do
    it 'should have get key route' do
      expect(get: '/usettings/test.json').to route_to(
        controller: 'user_settings',
        action:     'show',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set key route' do
      expect(post: '/usettings/test.json').to route_to(
        controller: 'user_settings',
        action:     'create',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set once key route' do
      expect(put: '/usettings/test.json').to route_to(
        controller: 'user_settings',
        action:     'create_once',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have remove key route' do
      expect(delete: '/usettings/test.json').to route_to(
        controller: 'user_settings',
        action:     'destroy',
        key:        'test',
        format:     'json'
      )
    end
  end

  context 'with special prefix' do
    let(:new_path) { 'non_default_path/' }

    around do |example|
      default_base_path = UserSettings.base_path
      UserSettings.base_path = new_path

      Rails.application.reload_routes!

      example.run

      UserSettings.base_path = default_base_path
      Rails.application.reload_routes!
    end

    it 'should have get key route' do
      expect(get: "/#{new_path}/test.json").to route_to(
        controller: 'user_settings',
        action:     'show',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set key route' do
      expect(post: "/#{new_path}/test.json").to route_to(
        controller: 'user_settings',
        action:     'create',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set once key route' do
      expect(put: "/#{new_path}/test.json").to route_to(
        controller: 'user_settings',
        action:     'create_once',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have remove key route' do
      expect(delete: "/#{new_path}/test.json").to route_to(
        controller: 'user_settings',
        action:     'destroy',
        key:        'test',
        format:     'json'
      )
    end
  end
end
