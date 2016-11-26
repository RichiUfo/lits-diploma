every 1.day, at: '4:00 am' do
  rake 'receive_events:run', output: { standard: '~/.log/receive_events.log',
                                       error: '~/.log/receive_events_errors.log' }
end
