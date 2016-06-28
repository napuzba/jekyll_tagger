module Jekyll_Tagger
  class Pager
    attr_reader :items , :item_count, :page_size ,:page_count, :url_maker
    attr_writer :index
    def initialize(items,page_size,url_maker)
      @items      = items
      @page_size  = page_size
      @url_maker  = url_maker

      @item_count = items.count
      @page_count = @page_size != 0 ? ((@item_count / @page_size) + (@item_count % @page_size > 0 ? 1 : 0)) : 1
    end

    def page_items(kk)
      return @page_size != 0 ? @items[((kk-1)*@page_size)..(kk*@page_size-1)] : @items
    end

    def page_list(number,page_show,current)
      pages = []
      ps = page_show-1
      s1 = current - ps/2
      s2 = current + ps/2 + ps%2
      if s1 < 1
        s2 += (1 - s1)
        s1  = 1
      end
      if s2 > page_count
        s1 -= (s2 - page_count)
        s2  = page_count
        if s1 < 1
          s1 = 1
        end
      end
      for kk in (s1)..(s2)
        pages.push(PageInfo.new(self,kk,kk==current))
      end
      return pages
    end

    def page_next(number)
      return PageInfo.new(self,number+1,false)
    end
    def page_prev(number)
      return PageInfo.new(self,number-1,false)
    end

    def page_first(number)
      return PageInfo.new(self,1,number==1)
    end
    def page_last(number)
      return PageInfo.new(self,@page_count,number==@page_count)
    end
  end
end
