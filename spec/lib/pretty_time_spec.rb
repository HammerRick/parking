require 'rails_helper'

RSpec.describe PrettyTime do
  include PrettyTime
  describe 'test seconds to pretty_time' do
    it 'returns 0 minutes for 59' do
      expect(normalize_time(59)).to eq('0 minutes')
    end

    it 'returns 1 minute for 60' do
      expect(normalize_time(60)).to eq('1 minute')
    end

    it 'returns 59 minutes for 3599' do
      expect(normalize_time(3599)).to eq('59 minutes')
    end

    it 'returns 1 hour for 3600' do
      expect(normalize_time(3600)).to eq('1 hour')
    end

    it 'returns 2 hours for 7200' do
      expect(normalize_time(7200)).to eq('2 hours')
    end

    it 'returns 2 hours 30 minutes for 9000' do
      expect(normalize_time(9000)).to eq('2 hours 30 minutes')
    end

    it 'returns 1 day 2 hours 30 minutes for 95_400' do
      expect(normalize_time(95_400)).to eq('1 day 2 hours 30 minutes')
    end

    it 'returns 2 days 30 minutes for 174_600' do
      expect(normalize_time(174_600)).to eq('2 days 30 minutes')
    end
  end
end
