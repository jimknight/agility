module EmailHelper
  def body
    return "" if @parent.class == Project
    @parent.body
  end
  def sent_to
    return "" if params[:type] == "forward"
    return "" if @parent.class == Project
    @parent.sent_from
  end
  def copy_to
    return "" if params[:type] == "forward"
    return "" if @parent.class == Project
    @parent.copy_to
  end
  def subject
    return @parent.title if @parent.class == Project
    if params[:type] == "forward"
      "Fw: #{@parent.subject}"
    else
      "Re: #{@parent.subject}"
    end
  end
end