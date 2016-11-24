every '* * * * *' do
  rake 'receive_events:run', output: { standard: '~/.log/receive_events.log',
                                       error: '~/.log/receive_events_errors.log' }
end
