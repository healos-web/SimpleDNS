class ResourceRecordsController < ApplicationControllerBase
  get '/addresses/:host_name' do
    record = ResourceRecord.find_by(host_name: params[:host_name])

    json record: record.record_value
  end

  get '/addresses_csv_file' do
    CSV.open('public/records.csv', 'w') do |csv|
      lines = ResourceRecord.pluck(:host_name, :record_type, :ttl, :record_value)
      lines.unshift(%w[Name Type TTL Record])
      lines.each { |line| csv << line }
    end

    send_file 'public/records.csv'
  end

  post '/addresses' do
    record = ResourceRecord.new(
      ttl: params[:ttl].to_i,
      record_type: params[:record_type],
      host_name: params[:host_name].downcase,
      record_value: params[:record_value]
    )

    if record.valid?
      record.save
      flash.next[:success] = "Success! Record was saved!"
    else
      flash.next[:danger] = build_error_flash(record)
    end
    
    redirect '/'
  end

  post '/addresses_from_csv' do
    errors = []

    CSV.foreach(params[:file][:tempfile].path, headers: true).with_index(1) do |line, lineno|
      ResourceRecord.find_or_create_by!(host_name: line[0].downcase) do |record|
        record.record_type = line[1]
        record.ttl = line[2].to_i
        record.record = line[3]
      end
    rescue => e
      errors.push("#{lineno} - #{e}")
    end

    flash.next[:danger] = errors.join("\n") if errors.any?
    flash.next[:success] = 'Done! Your records were saved successfully!'

    redirect '/'
  end

  private

  def build_error_flash(record)
    error_messages = record.errors.messages
    message = "Error! Record isn't valid:\n"
    error_messages.keys.each do |key|
      message += "\u2022 #{key.to_s.humanize} #{error_messages[key].join(' and')}\n"
    end

    message
  end
end