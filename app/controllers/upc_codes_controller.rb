class UpcCodesController < AdminController

  def bulk_create
    added = Array.new
    skipped = Array.new
    listOfCodes = params[:listOfCodes]
    begin
      #upc_codes = dynamo_db.tables['upc_codes']
      #upc_codes.provision_throughput  :write_capacity_units => 1000
      listOfCodes.split(/\r\n/).each do |c|
        code = UPCCode.new
        code.code = c
        code.active = 1
        if (!c.blank?) then
          if (c.length == 12) then
            # && UPCCode.where(:code=>code.code).where(:active=>1).first.blank?) then
            code.save
            added.push(code)
          else
            skipped.push(c)
          end
        end
      end
    ensure
      #upc_codes.provision_throughput  :write_capacity_units => 1
    end
    render :json => { :added => added, :skipped => skipped}
  end

  def new

  end

  def create
    code = UPCCode.new
    code.code = params[:code]
    code.active = 1
    if (UPCCode.where(:code=>code.code).where(:active=>1).first.blank?) then
      save(code)
    else
      render :json => { :errors => "Cannot add duplicate code: " + code.code}, :status=>422
    end
  end

  def destroy
    code = UPCCode.find(params[:id])
    code.active = 0
    save(code)
  end

  def save(code)
    if code.save then
      render :json => code
    else
      render :json => { :errors => code.errors.full_messages }, :status => 422
    end
  end

  def next
    render :json => UPCCode.next
  end

end
