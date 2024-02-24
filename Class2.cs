using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Employee
{
    internal static class Class2
    {
        public static int CInt(string input)
        {
            int x = 0;
            int.TryParse(input, out x);
            return x;
        }
        public static double CDouble(string input)
        {
            double x = 0;
            double.TryParse(input, out x);
            return x;
        }
        public static float CFloat(string input)
        {
            float x = 0;
            float.TryParse(input, out x);
            return x;
        }
        public static decimal Cdecimal(string input)
        {
            decimal x = 0;
            decimal.TryParse(input, out x);
            return x;
        }
        public static DateTime CDate(string input)
        {
            DateTime dt = new DateTime();
            DateTime.TryParse(input, out dt);
            return dt;
        }
    }
}
