class WordsController < ApplicationController
  def test

    @words = Word.all

    if rand(10) == 0
      @test_word = @words.slice!(rand(@words.length))
    else
      @test_word = @words.slice!(rand(10))
    end
    @test_word ||= @words.slice!(0)

    if @test_word.nil?
      flash[:notice] = "You must enter some words for testing!"
      redirect_to words_url
      return
    end

  end

  # GET /words
  # GET /words.json
  def index
    @words = Word.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    if params[:test]
      if @word.english == params[:word][:english] && 
         @word.translation == params[:word][:translation]
        
        count = @word.remembercount + 1

        @word.update_attributes({remembered: true, remembercount: count})

        flash[:notice] = "You remembered!"
        
        redirect_to words_test_url

      else
        @word.update_attributes({remembered: false, remembercount: 0})

        flash[:notice] = "Oops! #{@word.english} = #{@word.translation}"

        redirect_to words_test_url
      end

    else

      respond_to do |format|
        if @word.update_attributes(params[:word])
          format.html { redirect_to @word, notice: 'Word was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @word.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end
end
