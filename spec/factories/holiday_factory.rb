time = DateTime.now
Factory.define :holiday do |h|
  h.leave_length 'many'
  h.leave_type 'etc'
  h.description "who ha"
  h.state 0
  h.reviewed_by 'rsmith'
  h.reviewed_on "#{DateTime.now}"
  h.begin_time "#{ time }"
  h.end_time "#{  time + 2.days}"
  h.association :user
end