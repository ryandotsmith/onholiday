Factory.define :holiday do |h|
  h.leave_type 'etc'
  h.description "who ha"
  h.state 0
  h.reviewed_by 'rsmith'
  h.reviewed_on "#{DateTime.now}"
  h.begin_time "#{ DateTime.now.beginning_of_day }"
  h.end_time "#{  DateTime.now.end_of_day + 2.days }"
  h.user_id 1
end