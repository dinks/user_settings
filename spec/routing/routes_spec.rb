require 'spec_helper'

describe 'Routes' do
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
    around do |example|
      default_base_path = UserSettings.base_path
      UserSettings.base_path = 'non_default_path'

      Rails.application.reload_routes!

      UserSettings.base_path = default_base_path
      Rails.application.reload_routes!
    end

    it 'should have get key route' do
      expect(get: '/non_default_path/test.json').to route_to(
        controller: 'user_settings',
        action:     'show',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set key route' do
      expect(post: '/non_default_path/test.json').to route_to(
        controller: 'user_settings',
        action:     'create',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have set once key route' do
      expect(put: '/non_default_path/test.json').to route_to(
        controller: 'user_settings',
        action:     'create_once',
        key:        'test',
        format:     'json'
      )
    end

    it 'should have remove key route' do
      expect(delete: '/non_default_path/test.json').to route_to(
        controller: 'user_settings',
        action:     'destroy',
        key:        'test',
        format:     'json'
      )
    end
  end
end
