module Postable  

    def NumWordsAM(double n) # converts double to words
    {
        @numbersArr = { "አንድ", "ሁለት", "ሦስት", "አራት", "አምስት", "ስድስት", "ሰባት", "ስምንት", "ዘጠኝ", "አስር", "አስራአንድ", "አስራሁለት", "አስራሦስት", "አስራአራት", "አስራአምስት", "አስራስድስት", "አስራሰባት", "አስራስምንት", "አስራዘጠኝ" }
        @tensArr = { "ሃያ", "ሰላሳ", "አርባ", "ሃምሳ", "ስልሳ", "ሰባ", "ሰማኒያ", "ዘጠና" }
        @suffixesArr = { "ሺህ", "ሚሊዮን", "ቢሊዮን", "ትሪሊዮን", "ኩዋድሪሊዮን", "ኩዊንቲሊዮን", "ሴክስቲሊዮን", "ሴፕቲሊዮን", "ኦክቲሊዮን", "ነኒሊዮን", "ዴሲሊዮን", "አንዴሲሊዮን", "ዱዎዴሲሊዮን", "ትሬዴሲሊዮን", "ኩዋትሮዴሲሊዮን", "ኩዊንዴሲሊዮን", "ሴክስዴሲሊዮን", "ሴፕትዴሲሊዮን", "ኦክቶዴሲሊዮን", "ኖቬምዴሲሊዮን", "ቪጂንቲሊዮን" }
        @words = "";

        @tens = false;

        if (n < 0)
        {
            words += "ነጌቲቭ ";
            n *= -1;
        }

        int power = (suffixesArr.Length + 1) * 3;

        while (power > 3)
        {
            double pow = Math.Pow(10, power);
            if (n >= pow)
            {
                if (n % pow > 0)
                {
                    words += NumWordsAM(Math.Floor(n / pow)) + " " + suffixesArr[(power / 3) - 1] + ", ";
                }
                else if (n % pow == 0)
                {
                    words += NumWordsAM(Math.Floor(n / pow)) + " " + suffixesArr[(power / 3) - 1];
                }
                n %= pow;
            }
            power -= 3;
        }
        if (n >= 1000)
        {
            if (n % 1000 > 0) words += NumWordsAM(Math.Floor(n / 1000)) + " ሺህ, ";
            else words += NumWordsAM(Math.Floor(n / 1000)) + " ሺህ";
            n %= 1000;
        }
        if (0 <= n && n <= 999)
        {
            if ((int)n / 100 > 0)
            {
                words += NumWordsAM(Math.Floor(n / 100)) + " መቶ";
                n %= 100;
            }
            if ((int)n / 10 > 1)
            {
                if (words != "")
                    words += " ";
                words += tensArr[(int)n / 10 - 2];
                tens = true;
                n %= 10;
            }

            if (n < 20 && n > 0)
            {
                if (words != "" && tens == false)
                    words += " ";
                words += (tens ? "-" + numbersArr[(int)n - 1] : numbersArr[(int)n - 1]);
                n -= Math.Floor(n);
            }
        }

        return words;

    }
end