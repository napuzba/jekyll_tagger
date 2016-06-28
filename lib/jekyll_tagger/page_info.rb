module Jekyll_Tagger
  class PageInfo < Liquid::Drop
    attr :number, :url, :selected

    def initialize(pager,number,selected)
      @pager    = pager
      @number   = number
      @url      = @pager.url_maker.call(number)
      @selected = selected
    end

    def valid
      return @number >= 1 && @number <= @pager.page_count
    end

    def liquid_method_missing(method)
      method
    end
  end
end