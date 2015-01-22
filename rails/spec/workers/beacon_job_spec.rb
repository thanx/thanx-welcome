require 'rails_helper'

describe BeaconJob do
  let(:params) {
    {
      id:                 34077,
      accuracy:           nil,
      dwell_time:         0.0,
      last_update_time:   "2015-01-22T02:52:02.000Z",
      proximity:          nil,
      rssi:               nil,
      beacon_rssi:        nil,
      update_time:        nil,
      start_time:         "2015-01-22T02:52:02.000Z",
      type:               "visit_start",
      json: {
        dwell_time:         "0",
        last_update_time:   "2015-01-22 02:52:02 +0000",
        start_time:         "2015-01-22 02:52:02 +0000",
        type:               "visit_start",
        user_id:            "19306",
        beacon: {
          identifier:         "QB92-S9XEB",
          name:               "Thanx - 180 Redwood St",
          battery:            "3",
          temperature:        "75"
        }.stringify_keys
      }.stringify_keys,
      user_id:            thanx_user_id,
      beacon_id:          beacon_id,
      created_at:         "2015-01-22T02:52:03.529Z",
      updated_at:         "2015-01-22T02:52:03.529Z"
    }.stringify_keys
  }
  let(:beacon_id) { 11 }
  let(:thanx_user_id) { 3 }

  it 'creates event' do
    expect { BeaconJob.perform(params) }.to change { Event.count }.by(1)
  end

  context 'created event' do
    let(:event) { Event.last }

    it 'sets ibeacon_id' do
      BeaconJob.perform(params)
      expect(event.ibeacon_id).to eq(beacon_id)
    end

    it 'sets params' do
      BeaconJob.perform(params)
      expect(event.params).to eq(params)
    end

    context 'user' do
      let!(:user) { FactoryGirl.create :user, thanx_id: thanx_user_id }

      it 'matches event to user' do
        BeaconJob.perform(params)
        expect(event.user).to eq(user)
      end
    end

  end

end
