Factory.define :holiday do |h|
  h.leave_type 'etc'
  h.state 0
  h.reviewed_by 'rsmith'
  h.reviewed_on "#{DateTime.now}"
  h.begin_time "#{DateTime.now}"
  h.end_time "#{DateTime.now + 2.days}"
  h.user_id 1
end