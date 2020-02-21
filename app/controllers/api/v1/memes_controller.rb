class Api::V1::MemesController < ApplicationController

    def index
        @memes = Meme.all    
        render json: @memes, status: :ok
    end

    def show
        @meme = Meme.find(params[:id])
        render json: @meme, status: :ok    
    end

    def create
        @meme = Meme.create({
          url: params[:url],
          subreddit_id: params[:id].to_i,
          title: params[:title]
        })
    
        if @meme.save
          render json: @meme, status: :ok
        else
          render json: {errors: @meme.errors.full_messages[0]}
        end
    end
    
    def update
      @meme = Meme.find(params[:id])
      if params[:url]
        @meme.update({ url: params[:url] })
      end
      if params[:title]
        @meme.update({ title: params[:title] })
      end
      if params[:subreddit]
        @meme.update({ subreddit_id: params[:subreddit].to_i })
      end

      if @meme.save
        render json: @meme, status: :ok
      else
        render json: {errors: @meme.errors.full_messages[0]}
      end
    end

end
