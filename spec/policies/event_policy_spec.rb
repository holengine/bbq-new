require 'spec_helper'
require 'rails_helper'
require 'pundit/rspec'

RSpec.describe EventPolicy, type: :policy do
  let(:owner_user) { UserPundit.new(User.new, { cookies: nil, pincode: '' }) }
  let(:usual_user) { UserPundit.new(User.new, { cookies: nil, pincode: '' }) }
  let(:anon_user) { UserPundit.new(nil, { cookies: nil, pincode: '' }) }

  let(:event) { Event.new(user: owner_user.user) }
  let(:event_w_pin) { Event.new(user: owner_user.user, pincode: '111') }

  subject { described_class }

  permissions 'create?' do
    it 'access to create' do
      expect(subject).to permit(usual_user, Event)
    end

    it 'not access to create' do
      expect(subject).not_to permit(anon_user, Event)
    end
  end

  permissions 'show?' do
    context 'no pincode' do
      it 'access for owner' do
        expect(subject).to permit(owner_user, event)
      end

      it 'access for usual user' do
        expect(subject).to permit(usual_user, event)
      end

      it 'access for anon user' do
        expect(subject).to permit(anon_user, event)
      end
    end

    context 'pincode exist' do
      context 'for owner' do
        it 'access' do
          expect(subject).to permit(owner_user, event_w_pin)
        end
      end

      context 'for usual user' do
        it 'not access' do
          allow(usual_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).not_to permit(usual_user, event_w_pin)
        end

        it 'access with correct pin' do
          usual_user.params[:pincode] = '111'
          allow(usual_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).to permit(usual_user, event_w_pin)
        end

        it 'access with correct cookies' do
          allow(usual_user.params[:cookies]).to receive(:permanent).and_return({ "events_#{event_w_pin.id}_pincode" => '111' })
          expect(subject).to permit(usual_user, event_w_pin)
        end
      end

      context 'for anon user' do
        it 'not access' do
          allow(anon_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).not_to permit(anon_user, event_w_pin)
        end

        it 'access with correct pin' do
          anon_user.params[:pincode] = '111'
          allow(anon_user.params[:cookies]).to receive(:permanent).and_return({})
          expect(subject).to permit(anon_user, event_w_pin)
        end

        it 'access with correct cookies' do
          allow(anon_user.params[:cookies]).to receive(:permanent).and_return({ "events_#{event_w_pin.id}_pincode" => '111' })
          expect(subject).to permit(anon_user, event_w_pin)
        end
      end
    end
  end

  permissions 'update?' do
    context 'for owner' do
      it 'access' do
        expect(subject).to permit(owner_user, event)
      end
    end

    context 'for usual user' do
      it 'not access' do
        expect(subject).not_to permit(usual_user, event)
      end
    end

    context 'for anon user' do
      it 'access' do
        expect(subject).not_to permit(usual_user, event)
      end
    end
  end
end
