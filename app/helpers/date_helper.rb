require 'date'

module DateHelper

    month_name_amh=['መስከረም', 'ጥቅምት', 'ኅዳር', 'ታህሣሥ', 'ጥር', 'የካቲት','መጋቢት', 'ሚያዝያ', 'ግንቦት', 'ሰኔ', 'ሐምሌ', 'ነሐሴ', 'ጳጉሜ'];
    month_name_amh_short= ['መስከ', 'ጥቅም', 'ኅዳር', 'ታህሣ', 'ጥር', 'የካቲ','መጋቢ', 'ሚያዝ', 'ግንቦ', 'ሰኔ', 'ሐምሌ', 'ነሐሴ', 'ጳጉሜ'];
    day_name_amh = ['ሰኞ', 'ማክሰኞ', 'ረቡዕ', 'ሓሙስ', 'ዓርብ', 'ቅዳሜ', 'እሑድ'];
    day_name_amh_short = ['ሰኞ', 'ማክ', 'ረቡ', 'ሐሙ', 'ዓር', 'ቅዳ', 'እሑ'];

    def self.startDayOfEthiopian(year)
        newYearDay = (year / 100).floor - (year / 400).floor - 4
        # if the prev ethiopian year is a leap year, new-year occrus on 12th
        return (year - 1) % 4 === 3 ? newYearDay + 1 : newYearDay
    end

    def toGregorian(str)
        DateHelper.toGregorian(str)
    end

    def self.toGregorian(eth_date)
        eth_date_array = eth_date.split("-")
        year = eth_date_array[0].to_i
        month = eth_date_array[1].to_i
        date = eth_date_array[2].to_i

        # Ethiopian new year in Gregorian calendar
        newYearDay = startDayOfEthiopian(year)

        # September (Ethiopian) sees 7y difference
        gregorianYear = year + 7

        # Number of days in gregorian months
        # starting with September (index 1)
        # Index 0 is reserved for leap years switches.
        # Index 4 is December, the final month of the year.
        gregorianMonths = [0.0, 30, 31, 30, 31, 31, 28, 31, 30, 31, 30, 31, 31, 30]

        # if next gregorian year is leap year, February has 29 days.
        nextYear = gregorianYear + 1
        if (nextYear % 4 === 0 && nextYear % 100 != 0 || nextYear % 400 === 0)
            gregorianMonths[6] = 29
        end

        # calculate number of days up to that date
        _until = (month - 1) * 30.0 + date
        if (_until <= 37 && year <= 1575)
            # mysterious rule
            _until += 28
            gregorianMonths[0] = 31
        else 
            _until += newYearDay - 1
        end

        # if ethiopian year is leap year, paguemain has six days
        if (year - 1 % 4 === 3)
            _until += 1
        end

        # calculate month and date incremently
        m = 0
        gregorianDate = 0
        for i in 0..gregorianMonths.count
            if (_until <= gregorianMonths[i])
                m = i
                gregorianDate = _until
                break
            else
                m = i
                _until -= gregorianMonths[i]
            end
        end

        # if m > 4, we're already on next Gregorian year
        if (m > 4)
            gregorianYear += 1
        end

        # Gregorian months ordered according to Ethiopian
        order = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        gregorianMonths = order[m]
        return Date.new(gregorianYear, gregorianMonths, gregorianDate)
    end

    def toEthiopian(str)
        DateHelper.toEthiopian(str)
    end

    def self.toEthiopian(greg_date)
        year = greg_date.year
        month = greg_date.month
        date = greg_date.day

        # date between 5 and 14 of May 1582 are invalid
        if (month === 10 && date >= 5 && date <= 14 && year === 1582)
            throw new Exception('Invalid Date between 5-14 May 1582.')
        end

        # Number of days in gregorian months
        # starting with January (index 1)
        # Index 0 is reserved for leap years switches.
        gregorianMonths = [0.0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        # Number of days in ethiopian months
        # starting with January (index 1)
        # Index 0 is reserved for leap years switches.
        # Index 10 is month 13, the final month of the year
        ethiopianMonths = [0.0, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5, 30, 30, 30, 30]

        # if gregorian leap year, February has 29 days.
        if (year % 4 === 0 && year % 100 != 0 || year % 400 === 0)
            gregorianMonths[2] = 29
        end

        # September sees 8y difference
        ethiopianYear = year - 8

        # if ethiopian leap year pagumain has 6 days
        if (ethiopianYear % 4 === 3)
            ethiopianMonths[10] = 6
        end

        # Ethiopian new year in Gregorian calendar
        newYearDay = startDayOfEthiopian(year - 8)

        # calculate number of days up to that date
        _until = 0
        i = 1
        while i < month
            _until += gregorianMonths[i]
            i = i + 1
        end
        _until += date

        # update tahissas (december) to match january 1st
        tahissas = ethiopianYear % 4 == 0 ? 26 : 25

        # take into account the 1582 change
        if (year < 1582)
            ethiopianMonths[1] = 0
            ethiopianMonths[2] = tahissas
        elsif (_until <= 277 && year === 1582)
            ethiopianMonths[1] = 0
            ethiopianMonths[2] = tahissas
        else
            tahissas = newYearDay - 3
            ethiopianMonths[1] = tahissas
        end

        # calculate month and date incremently
        m = nil
        ethiopianDate = nil
        count = ethiopianMonths.length-1
        for m in 1..count
            if (_until <= ethiopianMonths[m])
                ethiopianDate = m === 1 || ethiopianMonths[m] === 0 ? _until + (30 - tahissas) : _until
                break
            else
                _until -= ethiopianMonths[m]
            end
        end

        # if m > 10, we're already on next Ethiopian year
        if (m > 10)
            ethiopianYear += 1
        end

        # Ethiopian months ordered according to Gregorian
        order = [0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4]
        ethiopianMonth = order[m]
        return ethiopianYear.to_s + "-" + ethiopianMonth.to_s + "-" + ethiopianDate.to_s
    end

    def toEthiopianWord(str)
        DateHelper.toEthiopianWord(str)
    end

    def self.toEthiopianWord (greg_date)
        month_name_amh=['Meskerem', 'Tikimt', 'Hidar', 'Tahisas', 'Tir', 'Yekatit','Megabit', 'Miyazia', 'Ginbot', 'Sene', 'Hamle', 'Nehase', 'Puagume'];
        eth_date = toEthiopian(greg_date)
        eth_date_array = eth_date.split("-")
        year = eth_date_array[0]
        month = eth_date_array[1].to_i
        date = eth_date_array[2]
        return month_name_amh[month-1] + " " + date + ", " + year + " E.C."
    end

    puts ("Converted date is: " + toGregorian('2011-13-6').to_s)
    # puts ("Converted date is: " + toEthiopian({'year'=>2019,'month'=>9,'date'=>11}).to_s)
    # puts ("Converted date is: " + toEthiopian(Date.new(2019,9,11)).to_s)
end