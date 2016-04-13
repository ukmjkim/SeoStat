class RankingsController < ApplicationController 
    def index
        if (params[:sdate].blank?) then params[:sdate] = "2016-02-01" end
        if (params[:edate].blank?) then params[:edate] = "2016-02-01" end
        if (params[:ranking_type].blank?) then params[:ranking_type] = "raw" end

        if params[:ranking_type].to_s == "average"
        ranking = Ranking.select("search_date, avg(google) as google, avg(yahoo) as yahoo, avg(bing) as bing").where("search_date >= ? AND search_date <= ?", params[:sdate], params[:edate]).group("search_date");
        @rankings = ranking.paginate(:page => params[:page], :per_page => 30)
        elsif params[:ranking_type].to_s == "weighted"
        ranking = Ranking.select("search_date, avg(global_monthly_searches) avg_global, max(global_monthly_searches) as max_global, avg(google) as google, avg(yahoo) as yahoo, avg(bing) as bing").where("search_date >= ? AND search_date <= ?", params[:sdate], params[:edate]).group("search_date");
        @rankings = ranking.paginate(:page => params[:page], :per_page => 30)
        else
        ranking = Ranking.where("search_date >= ? AND search_date <= ?", params[:sdate], params[:sdate])
        @rankings = ranking.paginate(:page => params[:page], :per_page => 30)
        end
        response do |format|
           format.html
           format.csv { send_data @rankings.to_csv }
           format.xls # { send_data @rankings.to_csv(col_sep: "\t") }
        end
    end

    def import
        Ranking.import(params[:file])
        redirect_to root_url, notice: "Rankings imported."
    end
end
