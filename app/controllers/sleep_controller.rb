class SleepController < ApplicationController

  def need_sleep
    sleep = HTTParty.get(
      'https://jawbone.com/nudge/api/users/@me/sleeps',
      :headers => { "Authorization" => "Bearer #{params[:token]}" }
    )

    yesterday = Time.now -  24.hours
    range = (yesterday..Time.now)

    complete_sleep_events = sleep["data"]["items"].keep_if { |x| range.cover?(Time.at(x["details"]["asleep_time"])) }

    # subtracts awake time from sleep mode duration for each sleep event
    total_complete_sleep = complete_sleep_events.collect do |x| (x["details"]["duration"] / 60.0 / 60.0) - (x["details"]["awake"] / 60.0 / 60.0) end

    partial_sleep_events = sleep["data"]["items"].keep_if { |x| range.cover?(Time.at(x["details"]["awake_time"])) && !range.cover?(Time.at(x["details"]["asleep_time"]))}  

    total_partial_sleep = partial_sleep_events.collect {|x| (Time.at(x["details"]["awake_time"]) - yesterday) / 60.0 / 60.0}


    sleep24 = total_partial_sleep.sum + total_complete_sleep.sum 
    
    render :json => {:sleep24 => sleep24, :can_commit => !(sleep24 < 7) }


  end

end
