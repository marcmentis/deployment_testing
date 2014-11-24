json.array!(@weekly_notes) do |weekly_note|
  json.extract! weekly_note, :id, :danger_yn, :drugs_last_changed, :drugs_not_why, :drugs_change_why, :meeting_date, :patient_id, :pre_date_yesno, :pre_date_no_why, :pre_date
  json.url weekly_note_url(weekly_note, format: :json)
end
