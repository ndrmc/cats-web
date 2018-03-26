module Number  

    def num_to_am_words(n) # converts double to words
        @numbersArr = [ "አንድ", "ሁለት", "ሦስት", "አራት", "አምስት", "ስድስት", "ሰባት", "ስምንት", "ዘጠኝ", "አስር", "አስራአንድ", "አስራሁለት", "አስራሦስት", "አስራአራት", "አስራአምስት", "አስራስድስት", "አስራሰባት", "አስራስምንት", "አስራዘጠኝ" ]
        @tensArr = [ "ሃያ", "ሰላሳ", "አርባ", "ሃምሳ", "ስልሳ", "ሰባ", "ሰማኒያ", "ዘጠና" ]
        @suffixesArr = [ "ሺህ", "ሚሊዮን", "ቢሊዮን", "ትሪሊዮን", "ኩዋድሪሊዮን", "ኩዊንቲሊዮን", "ሴክስቲሊዮን", "ሴፕቲሊዮን", "ኦክቲሊዮን", "ነኒሊዮን", "ዴሲሊዮን", "አንዴሲሊዮን", "ዱዎዴሲሊዮን", "ትሬዴሲሊዮን", "ኩዋትሮዴሲሊዮን", "ኩዊንዴሲሊዮን", "ሴክስዴሲሊዮን", "ሴፕትዴሲሊዮን", "ኦክቶዴሲሊዮን", "ኖቬምዴሲሊዮን", "ቪጂንቲሊዮን" ]
        @words = ""

        @tens = false

        if (n < 0)
            @words += "ነጌቲቭ "
            n *= -1
        end

        @power = (@suffixesArr.length + 1) * 3

        while (@power > 3) do
            pow = 10**@power
            if (n >= pow)
                if (n % pow > 0)
                    @words += num_to_am_words((n / pow).floor) + " " + @suffixesArr[(@power / 3) - 1] + ", "
                elsif (n % pow == 0)
                    @words += num_to_am_words((n / pow).floor) + " " + @suffixesArr[(@power / 3) - 1]
                end
                n %= pow
            end
            @power -= 3
        end
        if (n >= 1000)
            if (n % 1000 > 0) 
                @words += num_to_am_words((n / 1000).floor) + " ሺህ, "
            else 
                @words += num_to_am_words((n / 1000).floor) + " ሺህ"
                n %= 1000
            end
        end
        if (0 <= n && n <= 999)
            if (n.to_i / 100 > 0)
                @words += num_to_am_words((n / 100).floor) + " መቶ"
                n %= 100
            end
            if (n.to_i / 10 > 1)
                if (@words != "")
                    @words += " "
                end
                @words += @tensArr[n.to_i / 10 - 2]
                tens = true
                n %= 10
                
            end

            if (n < 20 && n > 0)
                if (@words != "" && tens == false)
                    @words += " "
                end
                @words += (tens ? "-" + @numbersArr[n.to_i - 1] : @numbersArr[n.to_i - 1])
                n -= n.floor
            end
        end
        return @words
    end

    def num_to_am_words_wrapper(number)
        @n = 0.00
        if (number.present?)
            @n = number
        end
        
        @words = ""
        @intPart = 0
        @decPart = 0
        if (@n == 0)
            return "ዜሮ"
        end
        @parts = @n.to_s.split(".")
        if(@parts.count > 1)
            @intPart = @parts[0].to_s.to_i
            @decPart = @parts[1].to_s.to_f
        end

        @words = num_to_am_words(@intPart)

        if (@decPart > 0)
            if (@words != "")
                @words += " ከ "
            end
            counter = @decPart.ToString().Length
            case counter
            when 1   
                @words += num_to_am_words(@decPart) + " አስረኛ"
            when 2  
                @words += num_to_am_words(@decPart) + " ሳንቲም"
            when 3
                @words += num_to_am_words(@decPart) + " ሺኛ"
            when 4   
                @words += num_to_am_words(@decPart) + " አስር-ሺኛ"
            when 5  
                @words += num_to_am_words(@decPart) + " መቶ-ሺኛ"
            when 6
                @words += num_to_am_words(@decPart) + " ሚሊየንኛ"
            when 7
                @words += num_to_am_words(@decPart) + " አስር-ሚሊየንኛ"
            end
        end
        return @words
    end
end