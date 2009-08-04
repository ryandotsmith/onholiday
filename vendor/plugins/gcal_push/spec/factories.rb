time = DateTime.now

Factory.sequence( :login ) { |n| "person#{n} " }

Factory.define :user do |u|
  u.login { Factory.next :login }
  u.max_personal 10.0
  u.max_etc 10.0
  u.max_vacation 10.0
end
Factory.define :holiday do |h|
  h.leave_length 'many'
  h.leave_type 'etcccccc'
  h.description "who ha"
  h.state 1
  h.reviewed_by 'rsmith'
  h.reviewed_on "#{DateTime.now}"
  h.begin_time "#{ time }"
  h.end_time "#{  time + 2.days}"
  h.association :user
end
Factory.define :pusher, :class  => Gcal::Pusher do |pusher|
end
