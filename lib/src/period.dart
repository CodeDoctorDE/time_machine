// https://github.com/nodatime/nodatime/blob/master/src/NodaTime/Period.cs
// fa6874e  on Dec 8, 2017

import 'package:meta/meta.dart';
import 'package:quiver_hashcode/hashcode.dart';

import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_utilities.dart';
import 'package:time_machine/time_machine_calendars.dart';

@immutable @private
class DateComponentsBetweenResult {
  // @private static LocalDate DateComponentsBetween(LocalDate start, LocalDate end, PeriodUnits units,
  //     out int years, out int months, out int weeks, out int days)

  final LocalDate date;
  final int years;
  final int months;
  final int weeks;
  final int days;

  DateComponentsBetweenResult(this.date, this.years, this.months, this.weeks, this.days);
}

// @private static void TimeComponentsBetween(int totalNanoseconds, PeriodUnits units,
// out int hours, out int minutes, out int seconds, out int milliseconds, out int ticks, out int nanoseconds)
@immutable @private
class TimeComponentsBetweenResult {
  int hours;
  int minutes;
  int seconds;
  int milliseconds;
  int ticks;
  int nanoseconds;

  TimeComponentsBetweenResult(this.hours, this.minutes, this.seconds, this.milliseconds, this.ticks, this.nanoseconds);
}


/// Represents a period of time expressed in human chronological terms: hours, days,
/// weeks, months and so on.
/// 
/// <remarks>
/// <para>
/// A <see cref="Period"/> contains a set of properties such as <see cref="Years"/>, <see cref="Months"/>, and so on
/// that return the number of each unit contained within this period. Note that these properties are not normalized in
/// any way by default, and so a <see cref="Period"/> may contain values such as "2 hours and 90 minutes". The
/// <see cref="Normalize"/> method will convert equivalent periods into a standard representation.
/// </para>
/// <para>
/// Periods can contain negative units as well as positive units ("+2 hours, -43 minutes, +10 seconds"), but do not
/// differentiate between properties that are zero and those that are absent (i.e. a period created as "10 years"
/// and one created as "10 years, zero months" are equal periods; the <see cref="Months"/> property returns zero in
/// both cases).
/// </para>
/// <para>
/// <see cref="Period"/> equality is implemented by comparing each property's values individually.
/// </para>
/// <para>
/// Periods operate on calendar-related types such as
/// <see cref="LocalDateTime" /> whereas <see cref="Duration"/> operates on instants
/// on the time line. (Note that although <see cref="ZonedDateTime" /> includes both concepts, it only supports
/// duration-based arithmetic.)
/// </para>
/// </remarks>
/// <threadsafety>This type is immutable reference type. See the thread safety section of the user guide for more information.</threadsafety>
@immutable
class Period // : IEquatable<Period>
    {
// General implementation note: operations such as normalization work out the total number of nanoseconds as an Int64
// value. This can handle +/- 106,751 days, or 292 years. We could move to using BigInteger if we feel that's required,
// but it's unlikely to be an issue. Ideally, we'd switch to use BigInteger after detecting that it could be a problem,
// but without the hit of having to catch the exception...


  /// A period containing only zero-valued properties.
  ///
  /// <value>A period containing only zero-valued properties.</value>
  static const Period Zero = const Period();


  /// Returns an equality comparer which compares periods by first normalizing them - so 24 hours is deemed equal to 1 day, and so on.
  /// Note that as per the <see cref="Normalize"/> method, years and months are unchanged by normalization - so 12 months does not
  /// equal 1 year.
  ///
  /// <value>An equality comparer which compares periods by first normalizing them.</value>
// todo: what to do about this?
// static IEqualityComparer<Period> NormalizingEqualityComparer => NormalizingPeriodEqualityComparer.Instance;

// The fields that make up this period.


  /// Gets the number of nanoseconds within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of nanoseconds within this period.</value>
  final int Nanoseconds;


  /// Gets the number of ticks within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of ticks within this period.</value>
  final int Ticks;


  /// Gets the number of milliseconds within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of milliseconds within this period.</value>
  final int Milliseconds;


  /// Gets the number of seconds within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of seconds within this period.</value>
  final int Seconds;


  /// Gets the number of minutes within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of minutes within this period.</value>
  final int Minutes;


  /// Gets the number of hours within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of hours within this period.</value>
  final int Hours;


  /// Gets the number of days within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of days within this period.</value>
  final int Days;


  /// Gets the number of weeks within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of weeks within this period.</value>
  final int Weeks;


  /// Gets the number of months within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of months within this period.</value>
  final int Months;


  /// Gets the number of years within this period.
  ///
  /// <remarks>
  /// This property returns zero both when the property has been explicitly set to zero and when the period does not
  /// contain this property.
  /// </remarks>
  /// <value>The number of years within this period.</value>
  final int Years;


///// Creates a period with the given date values.
///// 
//@private Period(int years, int months, int weeks, int days)
//{
//  this.Years = years;
//  this.Months = months;
//  this.Weeks = weeks;
//  this.Days = days;
//}
//
//
///// Creates a period with the given time values.
///// 
//@private Period(int hours, int minutes, int seconds, int milliseconds, int ticks, int nanoseconds)
//{
//  this.Hours = hours;
//  this.Minutes = minutes;
//  this.Seconds = seconds;
//  this.Milliseconds = milliseconds;
//  this.Ticks = ticks;
//  this.Nanoseconds = nanoseconds;
//}

///// Creates a period with the given time values.
  @internal const Period({this.Years, this.Months, this.Weeks, this.Days, this.Hours, this.Minutes, this.Seconds,
    this.Milliseconds, this.Ticks, this.Nanoseconds});


///// Creates a new period from the given values.
///// 
//@internal Period(int years, int months, int weeks, int days, int hours, int minutes, int seconds,
//    int milliseconds, int ticks, int nanoseconds)
//{
//  this.Years = years;
//  this.Months = months;
//  this.Weeks = weeks;
//  this.Days = days;
//  this.Hours = hours;
//  this.Minutes = minutes;
//  this.Seconds = seconds;
//  this.Milliseconds = milliseconds;
//  this.Ticks = ticks;
//  this.Nanoseconds = nanoseconds;
//}

// todo: these are all terrible ... remove them ??? ... do they add extra or does tree shaking shank these?

  /// Creates a period representing the specified number of years.
  ///
  /// <param name="years">The number of years in the new period</param>
  /// <returns>A period consisting of the given number of years.</returns>
  factory Period.fromYears(int years) => new Period(Years: years);


  /// Creates a period representing the specified number of months.
  ///
  /// <param name="months">The number of months in the new period</param>
  /// <returns>A period consisting of the given number of months.</returns>
  factory Period.fromMonths(int months) => new Period(Months: months);


  /// Creates a period representing the specified number of weeks.
  ///
  /// <param name="weeks">The number of weeks in the new period</param>
  /// <returns>A period consisting of the given number of weeks.</returns>

  factory Period.fromWeeks(int weeks) => new Period(Weeks: weeks);


  /// Creates a period representing the specified number of days.
  ///
  /// <param name="days">The number of days in the new period</param>
  /// <returns>A period consisting of the given number of days.</returns>

  factory Period.fromDays(int days) => new Period(Days: days);


  /// Creates a period representing the specified number of hours.
  ///
  /// <param name="hours">The number of hours in the new period</param>
  /// <returns>A period consisting of the given number of hours.</returns>

  factory Period.fromHours(int hours) => new Period(Hours: hours);


  /// Creates a period representing the specified number of minutes.
  ///
  /// <param name="minutes">The number of minutes in the new period</param>
  /// <returns>A period consisting of the given number of minutes.</returns>

  factory Period.fromMinutes(int minutes) => new Period(Minutes: minutes);


  /// Creates a period representing the specified number of seconds.
  ///
  /// <param name="seconds">The number of seconds in the new period</param>
  /// <returns>A period consisting of the given number of seconds.</returns>

  factory Period.fromSeconds(int seconds) => new Period(Seconds: seconds);


  /// Creates a period representing the specified number of milliseconds.
  ///
  /// <param name="milliseconds">The number of milliseconds in the new period</param>
  /// <returns>A period consisting of the given number of milliseconds.</returns>

  factory Period.fromMilliseconds(int milliseconds) => new Period(Milliseconds: milliseconds);


  /// Creates a period representing the specified number of ticks.
  ///
  /// <param name="ticks">The number of ticks in the new period</param>
  /// <returns>A period consisting of the given number of ticks.</returns>

  factory Period.fromTicks(int ticks) => new Period(Ticks: ticks);


  /// Creates a period representing the specified number of nanooseconds.
  ///
  /// <param name="nanoseconds">The number of nanoseconds in the new period</param>
  /// <returns>A period consisting of the given number of nanoseconds.</returns>

  factory Period.fromNanoseconds(int nanoseconds) => new Period(Nanoseconds: nanoseconds);


  /// Adds two periods together, by simply adding the values for each property.
  ///
  /// <param name="left">The first period to add</param>
  /// <param name="right">The second period to add</param>
  /// <returns>The sum of the two periods. The units of the result will be the union of those in both
  /// periods.</returns>

  Period operator +(Period right) {
    Preconditions.checkNotNull(right, 'right');
    return new Period(Years: Years + right.Years,
        Months: Months + right.Months,
        Weeks: Weeks + right.Weeks,
        Days: Days + right.Days,
        Hours: Hours + right.Hours,
        Minutes: Minutes + right.Minutes,
        Seconds: Seconds + right.Seconds,
        Milliseconds: Milliseconds + right.Milliseconds,
        Ticks: Ticks + right.Ticks,
        Nanoseconds: Nanoseconds + right.Nanoseconds);
  }


  /// Creates an <see cref="IComparer{T}"/> for periods, using the given "base" local date/time.
  ///
  /// <remarks>
  /// Certain periods can't naturally be compared without more context - how "one month" compares to
  /// "30 days" depends on where you start. In order to compare two periods, the returned comparer
  /// effectively adds both periods to the "base" specified by <paramref name="baseDateTime"/> and compares
  /// the results. In some cases this arithmetic isn't actually required - when two periods can be
  /// converted to durations, the comparer uses that conversion for efficiency.
  /// </remarks>
  /// <param name="baseDateTime">The base local date/time to use for comparisons.</param>
  /// <returns>The new comparer.</returns>
// todo: what to do abuot IComparer?
// static IComparer<Period> CreateComparer(LocalDateTime baseDateTime) => new PeriodComparer(baseDateTime);


  /// Subtracts one period from another, by simply subtracting each property value.
  ///
  /// <param name="minuend">The period to subtract the second operand from</param>
  /// <param name="subtrahend">The period to subtract the first operand from</param>
  /// <returns>The result of subtracting all the values in the second operand from the values in the first. The
  /// units of the result will be the union of both periods, even if the subtraction caused some properties to
  /// become zero (so "2 weeks, 1 days" minus "2 weeks" is "zero weeks, 1 days", not "1 days").</returns>

  Period operator -(Period subtrahend) {
    Preconditions.checkNotNull(subtrahend, 'subtrahend');
    return new Period(
        Years: Years - subtrahend.Years,
        Months: Months - subtrahend.Months,
        Weeks: Weeks - subtrahend.Weeks,
        Days: Days - subtrahend.Days,
        Hours: Hours - subtrahend.Hours,
        Minutes: Minutes - subtrahend.Minutes,
        Seconds: Seconds - subtrahend.Seconds,
        Milliseconds: Milliseconds - subtrahend.Milliseconds,
        Ticks: Ticks - subtrahend.Ticks,
        Nanoseconds: Nanoseconds - subtrahend.Nanoseconds);
  }

  /// Returns the exact difference between two date/times or
  /// returns the period between a start and an end date/time, using only the given units.
  ///
  /// <remarks>
  /// If <paramref name="end"/> is before <paramref name="start" />, each property in the returned period
  /// will be negative. If the given set of units cannot exactly reach the end point (e.g. finding
  /// the difference between 1am and 3:15am in hours) the result will be such that adding it to <paramref name="start"/>
  /// will give a value between <paramref name="start"/> and <paramref name="end"/>. In other words,
  /// any rounding is "towards start"; this is true whether the resulting period is negative or positive.
  /// </remarks>
  /// <param name="start">Start date/time</param>
  /// <param name="end">End date/time</param>
  /// <param name="units">Units to use for calculations</param>
  /// <exception cref="ArgumentException"><paramref name="units"/> is empty or contained unknown values.</exception>
  /// <exception cref="ArgumentException"><paramref name="start"/> and <paramref name="end"/> use different calendars.</exception>
  /// <returns>The period between the given date/times, using the given units.</returns>

  static Period Between(LocalDateTime start, LocalDateTime end, [PeriodUnits units = PeriodUnits.dateAndTime]) {
    Preconditions.checkArgument(units != PeriodUnits.none, 'units', "Units must not be empty");
    Preconditions.checkArgument((units.value & ~PeriodUnits.allUnits.value) == 0, 'units', "Units contains an unknown value: $units");
    CalendarSystem calendar = start.Calendar;
    Preconditions.checkArgument(calendar == end.Calendar, 'end', "start and end must use the same calendar system");

    if (start == end) {
      return Zero;
    }

    // Adjust for situations like "days between 5th January 10am and 7th Janary 5am" which should be one
    // day, because if we actually reach 7th January with date fields, we've overshot.
    // The date adjustment will always be valid, because it's just moving it towards start.
    // We need this for all date-based period fields. We could potentially optimize by not doing this
    // in cases where we've only got time fields...
    LocalDate endDate = end.Date;
    if (start < end) {
      if (start.TimeOfDay > end.TimeOfDay) {
        endDate = endDate.PlusDays(-1);
      }
    }
    else if (start > end && start.TimeOfDay < end.TimeOfDay) {
      endDate = endDate.PlusDays(1);
    }

    // Optimization for single field
    switch (units) {
      case PeriodUnits.years:
        return new Period.fromYears(DatePeriodFields.YearsField.UnitsBetween(start.Date, endDate));
      case PeriodUnits.months:
        return new Period.fromMonths(DatePeriodFields.MonthsField.UnitsBetween(start.Date, endDate));
      case PeriodUnits.weeks:
        return new Period.fromWeeks(DatePeriodFields.WeeksField.UnitsBetween(start.Date, endDate));
      case PeriodUnits.days:
        return new Period.fromDays(DaysBetween(start.Date, endDate));
      case PeriodUnits.hours:
        return new Period.fromHours(TimePeriodField.Hours.UnitsBetween(start, end));
      case PeriodUnits.minutes:
        return new Period.fromMinutes(TimePeriodField.Minutes.UnitsBetween(start, end));
      case PeriodUnits.seconds:
        return new Period.fromSeconds(TimePeriodField.Seconds.UnitsBetween(start, end));
      case PeriodUnits.milliseconds:
        return new Period.fromMilliseconds(TimePeriodField.Milliseconds.UnitsBetween(start, end));
      case PeriodUnits.ticks:
        return new Period.fromTicks(TimePeriodField.Ticks.UnitsBetween(start, end));
      case PeriodUnits.nanoseconds:
        return new Period.fromNanoseconds(TimePeriodField.Nanoseconds.UnitsBetween(start, end));
    }

    // Multiple fields
    LocalDateTime remaining = start;
    int years = 0,
        months = 0,
        weeks = 0,
        days = 0;
    if ((units.value & PeriodUnits.allDateUnits.value) != 0) {
      // todo: deal with DateComponentsBetween
      throw new UnimplementedError('this is not done.');
//    LocalDate remainingDate = DateComponentsBetween(
//        start.Date, endDate, units, out years, out months, out weeks, out days);
//     remaining = new LocalDateTime(remainingDate, start.TimeOfDay);
    }
    if ((units.value & PeriodUnits.allTimeUnits.value) == 0) {
      return new Period(Years: years, Months: months, Weeks: weeks, Days: days);
    }

    // The remainder of the computation is with fixed-length units, so we can do it all with
    // Duration instead of Local* values. We don't know for sure that this is small though - we *could*
    // be trying to find the difference between 9998 BC and 9999 CE in nanoseconds...
    // Where we can optimize, do everything with int arithmetic (as we do for Between(LocalTime, LocalTime)).
    // Otherwise (rare case), use duration arithmetic.
    int hours, minutes, seconds, milliseconds, ticks, nanoseconds;
    var duration = end
        .ToLocalInstant()
        .TimeSinceLocalEpoch - remaining
        .ToLocalInstant()
        .TimeSinceLocalEpoch;
    if (duration.IsInt64Representable) {
      // todo: deal with TimeComponentsBetween
      throw new UnimplementedError('this is not done.');
      // TimeComponentsBetween(duration.ToInt64Nanoseconds(), units, out hours, out minutes, out seconds, out milliseconds, out ticks, out nanoseconds);
    }
    else {
      int UnitsBetween(PeriodUnits mask, TimePeriodField timeField) {
        if ((mask.value & units.value) == 0) {
          return 0;
        }
        int value = timeField.GetUnitsInDuration(duration);
        duration -= timeField.ToDuration(value);
        return value;
      }

      hours = UnitsBetween(PeriodUnits.hours, TimePeriodField.Hours);
      minutes = UnitsBetween(PeriodUnits.minutes, TimePeriodField.Minutes);
      seconds = UnitsBetween(PeriodUnits.seconds, TimePeriodField.Seconds);
      milliseconds = UnitsBetween(PeriodUnits.milliseconds, TimePeriodField.Milliseconds);
      ticks = UnitsBetween(PeriodUnits.ticks, TimePeriodField.Ticks);
      nanoseconds = UnitsBetween(PeriodUnits.ticks, TimePeriodField.Nanoseconds);
    }
    return new Period(Years: years,
        Months: months,
        Weeks: weeks,
        Days: days,
        Hours: hours,
        Minutes: minutes,
        Seconds: seconds,
        Milliseconds: milliseconds,
        Ticks: ticks,
        Nanoseconds: nanoseconds);
  }


  /// Common code to perform the date parts of the Between methods.
  ///
  /// <param name="start">Start date</param>
  /// <param name="end">End date</param>
  /// <param name="units">Units to compute</param>
  /// <param name="years">(Out) Year component of result</param>
  /// <param name="months">(Out) Months component of result</param>
  /// <param name="weeks">(Out) Weeks component of result</param>
  /// <param name="days">(Out) Days component of result</param>
  /// <returns>The resulting date after adding the result components to <paramref name="start"/> (to
  /// allow further computations to be made)</returns>
  @private static DateComponentsBetweenResult DateComponentsBetween(LocalDate start, LocalDate end, PeriodUnits units) {
    LocalDate result = start;

    /*
  int UnitsBetween(PeriodUnits maskedUnits, /*ref*/ LocalDate startDate, LocalDate endDate, IDatePeriodField dateField)
  {
    if (maskedUnits.value == 0)
    {
      return 0;
    }
    int value = dateField.UnitsBetween(startDate, endDate);
    startDate = dateField.Add(startDate, value);
    return value;
  }
  * */

    int UnitsBetween(int maskedUnits, IDatePeriodField dateField) {
      if (maskedUnits.value == 0) {
        return 0;
      }

      int value = dateField.UnitsBetween(result, end);
      result = dateField.Add(result, value);
      return value;
    }

    var years = UnitsBetween(units.value & PeriodUnits.years.value, DatePeriodFields.YearsField);
    var months = UnitsBetween(units.value & PeriodUnits.months.value, DatePeriodFields.MonthsField);
    var weeks = UnitsBetween(units.value & PeriodUnits.weeks.value, DatePeriodFields.WeeksField);
    var days = UnitsBetween(units.value & PeriodUnits.days.value, DatePeriodFields.DaysField);

    return new DateComponentsBetweenResult(result, years, months, weeks, days);
  }


  /// Common code to perform the time parts of the Between methods for long-representable nanos.
  ///
  /// <param name="totalNanoseconds">Number of nanoseconds to compute the units of</param>
  /// <param name="units">Units to compute</param>
  /// <param name="hours">(Out) Hours component of result</param>
  /// <param name="minutes">(Out) Minutes component of result</param>
  /// <param name="seconds">(Out) Seconds component of result</param>
  /// <param name="milliseconds">(Out) Milliseconds component of result</param>
  /// <param name="ticks">(Out) Ticks component of result</param>
  /// <param name="nanoseconds">(Out) Nanoseconds component of result</param>
  @private static TimeComponentsBetweenResult TimeComponentsBetween(int totalNanoseconds, PeriodUnits units) {
    int UnitsBetween(PeriodUnits mask, int nanosecondsPerUnit) {
      if ((mask.value & units.value) == 0) {
        return 0;
      }

      int value = totalNanoseconds ~/ nanosecondsPerUnit;
      // This has been tested and found to be faster than using totalNanoseconds %= nanosecondsPerUnit
      // todo: that was tested in dotnet, not dart
      totalNanoseconds -= value * nanosecondsPerUnit;
      return value;
    }

    var hours = UnitsBetween(PeriodUnits.hours, TimeConstants.nanosecondsPerHour);
    var minutes = UnitsBetween(PeriodUnits.minutes, TimeConstants.nanosecondsPerMinute);
    var seconds = UnitsBetween(PeriodUnits.seconds, TimeConstants.nanosecondsPerSecond);
    var milliseconds = UnitsBetween(PeriodUnits.milliseconds, TimeConstants.nanosecondsPerMillisecond);
    var ticks = UnitsBetween(PeriodUnits.ticks, TimeConstants.nanosecondsPerTick);
    var nanoseconds = UnitsBetween(PeriodUnits.nanoseconds, 1);

    return new TimeComponentsBetweenResult(hours, minutes, seconds, milliseconds, ticks, nanoseconds);
  }

// TODO(optimization): These three methods are only ever used with scalar values of 1 or -1. Unlikely that
// the multiplications are going to be relevant, but may be worth testing. (Easy enough to break out
// code for the two values separately.)


  /// Adds the time components of this period to the given time, scaled accordingly.
  ///

  @internal LocalTime AddTimeTo(LocalTime time, int scalar) =>
      time.PlusHours(Hours * scalar)
          .PlusMinutes(Minutes * scalar)
          .PlusSeconds(Seconds * scalar)
          .PlusMilliseconds(Milliseconds * scalar)
          .PlusTicks(Ticks * scalar)
          .PlusNanoseconds(Nanoseconds * scalar);


  /// Adds the date components of this period to the given time, scaled accordingly.
  ///

  @internal LocalDate AddDateTo(LocalDate date, int scalar) =>
      date.PlusYears(Years * scalar)
          .PlusMonths(Months * scalar)
          .PlusWeeks(Weeks * scalar)
          .PlusDays(Days * scalar);


  /// Adds the contents of this period to the given date and time, with the given scale (either 1 or -1, usually).
  ///
  @internal LocalDateTime AddDateTimeTo(LocalDate date, LocalTime time, int scalar) {
    date = AddDateTo(date, scalar);
    int extraDays = 0;
    time = TimePeriodField.Hours.Add(time, Hours * scalar, /*ref*/ extraDays);
    time = TimePeriodField.Minutes.Add(time, Minutes * scalar, /*ref*/ extraDays);
    time = TimePeriodField.Seconds.Add(time, Seconds * scalar, /*ref*/ extraDays);
    time = TimePeriodField.Milliseconds.Add(time, Milliseconds * scalar, /*ref*/ extraDays);
    time = TimePeriodField.Ticks.Add(time, Ticks * scalar, /*ref*/ extraDays);
    time = TimePeriodField.Nanoseconds.Add(time, Nanoseconds * scalar, /*ref*/ extraDays);
    // TODO(optimization): Investigate the performance impact of us calling PlusDays twice.
    // Could optimize by including that in a single call...
    return new LocalDateTime(date.PlusDays(extraDays), time);
  }

  /// Returns the exact difference between two dates or returns the period between a start and an end date, using only the given units.
  ///
  /// <remarks>
  /// If <paramref name="end"/> is before <paramref name="start" />, each property in the returned period
  /// will be negative. If the given set of units cannot exactly reach the end point (e.g. finding
  /// the difference between 12th February and 15th March in months) the result will be such that adding it to <paramref name="start"/>
  /// will give a value between <paramref name="start"/> and <paramref name="end"/>. In other words,
  /// any rounding is "towards start"; this is true whether the resulting period is negative or positive.
  /// </remarks>
  /// <param name="start">Start date</param>
  /// <param name="end">End date</param>
  /// <param name="units">Units to use for calculations</param>
  /// <exception cref="ArgumentException"><paramref name="units"/> contains time units, is empty or contains unknown values.</exception>
  /// <exception cref="ArgumentException"><paramref name="start"/> and <paramref name="end"/> use different calendars.</exception>
  /// <returns>The period between the given dates, using the given units.</returns>


  static Period BetweenDates(LocalDate start, LocalDate end, [PeriodUnits units = PeriodUnits.yearMonthDay]) {
    Preconditions.checkArgument((units.value & PeriodUnits.allTimeUnits.value) == 0, 'units', "Units contains time units: $units");
    Preconditions.checkArgument(units != 0, 'units', "Units must not be empty");
    Preconditions.checkArgument((units.value & ~PeriodUnits.allUnits.value) == 0, 'units', "Units contains an unknown value: $units");
    CalendarSystem calendar = start.Calendar;
    Preconditions.checkArgument(calendar == end.Calendar, 'end', "start and end must use the same calendar system");

    if (start == end) {
      return Zero;
    }

    // Optimization for single field
    switch (units) {
      case PeriodUnits.years:
        return new Period.fromYears(DatePeriodFields.YearsField.UnitsBetween(start, end));
      case PeriodUnits.months:
        return new Period.fromMonths(DatePeriodFields.MonthsField.UnitsBetween(start, end));
      case PeriodUnits.weeks:
        return new Period.fromWeeks(DatePeriodFields.WeeksField.UnitsBetween(start, end));
      case PeriodUnits.days:
        return new Period.fromDays(DaysBetween(start, end));
    }

    // Multiple fields todo: if these result_type functions are just used to make periods, we can simply them
    var result = DateComponentsBetween(start, end, units);
    return new Period(Years: result.years, Months: result.months, Weeks: result.weeks, Days: result.days);
  }

  /// Returns the exact difference between two times or returns the period between a start and an end time, using only the given units.
  ///
  /// <remarks>
  /// If <paramref name="end"/> is before <paramref name="start" />, each property in the returned period
  /// will be negative. If the given set of units cannot exactly reach the end point (e.g. finding
  /// the difference between 3am and 4.30am in hours) the result will be such that adding it to <paramref name="start"/>
  /// will give a value between <paramref name="start"/> and <paramref name="end"/>. In other words,
  /// any rounding is "towards start"; this is true whether the resulting period is negative or positive.
  /// </remarks>
  /// <param name="start">Start time</param>
  /// <param name="end">End time</param>
  /// <param name="units">Units to use for calculations</param>
  /// <exception cref="ArgumentException"><paramref name="units"/> contains date units, is empty or contains unknown values.</exception>
  /// <exception cref="ArgumentException"><paramref name="start"/> and <paramref name="end"/> use different calendars.</exception>
  /// <returns>The period between the given times, using the given units.</returns>


  static Period BetweenTimes(LocalTime start, LocalTime end, [PeriodUnits units = PeriodUnits.allTimeUnits]) {
    Preconditions.checkArgument((units.value & PeriodUnits.allDateUnits.value) == 0, 'units', "Units contains date units: $units");
    Preconditions.checkArgument(units != 0, 'units', "Units must not be empty");
    Preconditions.checkArgument((units.value & ~PeriodUnits.allUnits.value) == 0, 'units', "Units contains an unknown value: $units");

    // We know that the difference is in the range of +/- 1 day, which is a relatively small
    // number of nanoseconds. All the operations can be done with simple int division/remainder ops,
    // so we don't need to delegate to TimePeriodField.

    int remaining = (end.NanosecondOfDay - start.NanosecondOfDay);

    // Optimization for a single unit
    switch (units) {
      case PeriodUnits.hours:
        return new Period.fromHours(remaining ~/ TimeConstants.nanosecondsPerHour);
      case PeriodUnits.minutes:
        return new Period.fromMinutes(remaining ~/ TimeConstants.nanosecondsPerMinute);
      case PeriodUnits.seconds:
        return new Period.fromSeconds(remaining ~/ TimeConstants.nanosecondsPerSecond);
      case PeriodUnits.milliseconds:
        return new Period.fromMilliseconds(remaining ~/ TimeConstants.nanosecondsPerMillisecond);
      case PeriodUnits.ticks:
        return new Period.fromTicks(remaining ~/ TimeConstants.nanosecondsPerTick);
      case PeriodUnits.nanoseconds:
        return new Period.fromNanoseconds(remaining);
    }

    var result = TimeComponentsBetween(remaining, units);
    return new Period(Hours: result.hours,
        Minutes: result.minutes,
        Seconds: result.seconds,
        Milliseconds: result.milliseconds,
        Ticks: result.ticks,
        Nanoseconds: result.nanoseconds);
  }

  /// Returns the number of days between two dates. This allows optimizations in DateInterval,
  /// and for date calculations which just use days - we don't need state or a virtual method invocation.
  ///
  @internal static int DaysBetween(LocalDate start, LocalDate end) {
    // We already assume the calendars are the same.
    if (start.yearMonthDay == end.yearMonthDay) {
      return 0;
    }
    // Note: I've experimented with checking for the dates being in the same year and optimizing that.
    // It helps a little if they're in the same month, but just that test has a cost for other situations.
    // Being able to find the day of year if they're in the same year but different months doesn't help,
    // somewhat surprisingly.
    int startDays = start.DaysSinceEpoch;
    int endDays = end.DaysSinceEpoch;
    return endDays - startDays;
  }


  /// Returns whether or not this period contains any non-zero-valued time-based properties (hours or lower).
  ///
  /// <value>true if the period contains any non-zero-valued time-based properties (hours or lower); false otherwise.</value>
  bool get HasTimeComponent => Hours != 0 || Minutes != 0 || Seconds != 0 || Milliseconds != 0 || Ticks != 0 || Nanoseconds != 0;


  /// Returns whether or not this period contains any non-zero date-based properties (days or higher).
  ///
  /// <value>true if this period contains any non-zero date-based properties (days or higher); false otherwise.</value>
  bool get HasDateComponent => Years != 0 || Months != 0 || Weeks != 0 || Days != 0;


  /// For periods that do not contain a non-zero number of years or months, returns a duration for this period
  /// assuming a standard 7-day week, 24-hour day, 60-minute hour etc.
  ///
  /// <exception cref="InvalidOperationException">The month or year property in the period is non-zero.</exception>
  /// <exception cref="OverflowException">The period doesn't have years or months, but the calculation
  /// overflows the bounds of <see cref="Duration"/>. In some cases this may occur even though the theoretical
  /// result would be valid due to balancing positive and negative values, but for simplicity there is
  /// no attempt to work around this - in realistic periods, it shouldn't be a problem.</exception>
  /// <returns>The duration of the period.</returns>

  Span ToSpan() {
    if (Months != 0 || Years != 0) {
      // todo: is this real?
      throw new ArgumentError("Cannot construct span of period with non-zero months or years.");
    }
    return new Span(nanoseconds: TotalNanoseconds);
  }


  /// Gets the total number of nanoseconds duration for the 'standard' properties (all bar years and months).
  ///
  /// <value>The total number of nanoseconds duration for the 'standard' properties (all bar years and months).</value>
  @private int get TotalNanoseconds =>
      Nanoseconds +
          Ticks * TimeConstants.nanosecondsPerTick +
          Milliseconds * TimeConstants.nanosecondsPerMillisecond +
          Seconds * TimeConstants.nanosecondsPerSecond +
          Minutes * TimeConstants.nanosecondsPerMinute +
          Hours * TimeConstants.nanosecondsPerHour +
          Days * TimeConstants.nanosecondsPerDay +
          Weeks * TimeConstants.nanosecondsPerWeek;


  /// Creates a <see cref="PeriodBuilder"/> from this instance. The new builder
  /// is populated with the values from this period, but is then detached from it:
  /// changes made to the builder are not reflected in this period.
  ///
  /// <returns>A builder with the same values and units as this period.</returns>
  PeriodBuilder ToBuilder() => new PeriodBuilder(this);


  /// Returns a normalized version of this period, such that equivalent (but potentially non-equal) periods are
  /// changed to the same representation.
  ///
  /// <remarks>
  /// Months and years are unchanged
  /// (as they can vary in length), but weeks are multiplied by 7 and added to the
  /// Days property, and all time properties are normalized to their natural range.
  /// Subsecond values are normalized to millisecond and "nanosecond within millisecond" values.
  /// So for example, a period of 25 hours becomes a period of 1 day
  /// and 1 hour. A period of 1,500,750,000 nanoseconds becomes 1 second, 500 milliseconds and
  /// 750,000 nanoseconds. Aside from months and years, either all the properties
  /// end up positive, or they all end up negative. "Week" and "tick" units in the returned period are always 0.
  /// </remarks>
  /// <exception cref="OverflowException">The period doesn't have years or months, but it contains more than
  /// <see cref="Int64.MaxValue"/> nanoseconds when the combined weeks/days/time portions are considered. This is
  /// over 292 years, so unlikely to be a problem in normal usage.
  /// In some cases this may occur even though the theoretical result would be valid due to balancing positive and
  /// negative values, but for simplicity there is no attempt to work around this.</exception>
  /// <returns>The normalized period.</returns>
  /// <seealso cref="NormalizingEqualityComparer"/>
  Period Normalize() {
    // Simplest way to normalize: grab all the fields up to "week" and
    // sum them.
    int totalNanoseconds = TotalNanoseconds;
    int days = (totalNanoseconds ~/ TimeConstants.nanosecondsPerDay);
    int hours = (totalNanoseconds ~/ TimeConstants.nanosecondsPerHour) % TimeConstants.hoursPerDay;
    int minutes = (totalNanoseconds ~/ TimeConstants.nanosecondsPerMinute) % TimeConstants.minutesPerHour;
    int seconds = (totalNanoseconds ~/ TimeConstants.nanosecondsPerSecond) % TimeConstants.secondsPerMinute;
    int milliseconds = (totalNanoseconds ~/ TimeConstants.nanosecondsPerMillisecond) % TimeConstants.millisecondsPerSecond;
    int nanoseconds = totalNanoseconds % TimeConstants.nanosecondsPerMillisecond;

    return new Period(Years: this.Years,
        Months: this.Months,
        Weeks: 0 /* weeks */,
        Days: days,
        Hours: hours,
        Minutes: minutes,
        Seconds: seconds,
        Milliseconds: milliseconds,
        Ticks: 0 /* ticks */,
        Nanoseconds: nanoseconds);
  }

  /// Returns this string formatted according to the <see cref="PeriodPattern.Roundtrip"/>.
  ///
  /// <returns>A formatted representation of this period.</returns>
  @override String toString() => PeriodPattern.Roundtrip.Format(this);

  /// Returns the hash code for this period, consistent with <see cref="Equals(Period)"/>.
  ///
  /// <returns>The hash code for this period.</returns>
  @override int get hashCode => hashObjects([Years, Months, Weeks, Days, Hours, Minutes, Seconds, Milliseconds, Ticks, Nanoseconds]);

  /// Compares the given period for equality with this one.
  ///
  /// <remarks>
  /// Periods are equal if they contain the same values for the same properties.
  /// However, no normalization takes place, so "one hour" is not equal to "sixty minutes".
  /// </remarks>
  /// <param name="other">The period to compare this one with.</param>
  /// <returns>True if this period has the same values for the same properties as the one specified.</returns>
  bool Equals(Period other) =>
      other != null &&
          Years == other.Years &&
          Months == other.Months &&
          Weeks == other.Weeks &&
          Days == other.Days &&
          Hours == other.Hours &&
          Minutes == other.Minutes &&
          Seconds == other.Seconds &&
          Milliseconds == other.Milliseconds &&
          Ticks == other.Ticks &&
          Nanoseconds == other.Nanoseconds;
}

/// Equality comparer which simply normalizes periods before comparing them.
///
@private class NormalizingPeriodEqualityComparer // : EqualityComparer<Period>
    {
  @internal static final NormalizingPeriodEqualityComparer Instance = new NormalizingPeriodEqualityComparer();

  @private NormalizingPeriodEqualityComparer() {
  }

  @override bool Equals(Period x, Period y) {
    // todo: ReferenceEquals?
    if (x as Object == y as Object) {
      return true;
    }
    if (x == null || y == null) {
      return false;
    }
    return x.Normalize().Equals(y.Normalize());
  }

  @override int getHashCode(Period obj) =>
      Preconditions
          .checkNotNull(obj, 'obj')
          .Normalize()
          .hashCode;
}

// todo: implements Comparer
@private class PeriodComparer // implements Comparer<Period>
    {
  @private final LocalDateTime baseDateTime;

  @internal PeriodComparer(this.baseDateTime);

  @override int Compare(Period x, Period y) {
    // todo: ReferenceEquals?
    if (x as Object == y as Object) {
      return 0;
    }
    if (x == null) {
      return -1;
    }
    if (y == null) {
      return 1;
    }
    if (x.Months == 0 && y.Months == 0 &&
        x.Years == 0 && y.Years == 0) {
// Note: this *could* throw an OverflowException when the normal approach
// wouldn't, but it's highly unlikely
      return x.ToSpan().compareTo(y.ToSpan());
    }
    return (baseDateTime.Plus(x)).CompareTo(baseDateTime.Plus(y));
  }
}