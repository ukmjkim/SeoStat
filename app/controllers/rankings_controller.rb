class RankingsController < ApplicationController 
    def index
        if params[:ranking_type].to_s == "average"
        @rankings = Ranking.paginate(:page => params[:page], :per_page => 20)
        elsif params[:ranking_type].to_s == "weighted"
        @rankings = Ranking.paginate(:page => params[:page], :per_page => 30)
        else
        @rankings = Ranking.paginate(:page => params[:page], :per_page => 10)
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
