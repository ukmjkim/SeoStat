class RankingsController < ApplicationController 
    def index
        if params[:ranking_type].to_s == "average"
        ranking = Ranking.where("search_date >= ? AND search_date <= ?", params[:sdate], params[:sdate])
        @rankings = ranking.paginate(:page => params[:page], :per_page => 20)
        elsif params[:ranking_type].to_s == "weighted"
        ranking = Ranking.where("search_date >= ? AND search_date <= ?", params[:sdate], params[:sdate])
        @rankings = ranking.paginate(:page => params[:page], :per_page => 30)
        else
        ranking = Ranking.where("search_date >= ? AND search_date <= ?", params[:sdate], params[:sdate])
        @rankings = ranking.paginate(:page => params[:page], :per_page => 10)
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
