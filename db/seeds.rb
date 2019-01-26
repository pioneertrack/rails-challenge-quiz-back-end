unless User.any?
  User.create!(
    name: 'Test User',
    email: 'test@user.com',
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end

unless Event.any?
  user = User.first
  calendar = user.calendars.first
  date = DateTime.now

  [
    'first event',
    'second event',
    'third event'
  ].each_with_index do |title, i|
    Event.create!(
      title: title,
      start_time: date + i.hours,
      end_time: date + (i + 1).hours,
      calendar_id: calendar.id,
      user_id: user.id
    )
  end
end
