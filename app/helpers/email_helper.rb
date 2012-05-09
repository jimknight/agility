module EmailHelper
  def body
    @parent.body
  end
  def sent_to
    return "" if params[:type] == "forward"
    @parent.sent_from
  end
  def copy_to
    return "" if params[:type] == "forward"
    @parent.copy_to
  end
  def subject
    if params[:type] == "forward"
      "Fw: #{@parent.subject}"
    else
      "Re: #{@parent.subject}"
    end
  end
end