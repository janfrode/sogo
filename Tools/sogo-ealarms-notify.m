/* sogo-ealarms-notify.m - this file is part of SOGo
 *
 * Copyright (C) 2010 Inverse inc.
 *
 * Author: Wolfgang Sourdeau <wsourdeau@inverse.ca>
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This file is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSUserDefaults.h>

#import "SOGoEAlarmsNotifier.h"

int
main (int argc, char **argv, char **env)
{
  NSAutoreleasePool *pool;
  NSUserDefaults *ud;
  SOGoEAlarmsNotifier *notifier;
  int rc;

  rc = 0;

  pool = [NSAutoreleasePool new];

  ud = [NSUserDefaults standardUserDefaults];
  [ud addSuiteNamed: @"sogod"];

  if ([ud objectForKey: @"SOGoEnableEMailAlarms"])
    {
      notifier = [SOGoEAlarmsNotifier new];
      if (![notifier run])
	rc = -1;
      [notifier release];
    }
  else
    NSLog (@"EMail alarms are disabled in the SOGo configuration.");

  [pool release];

  return rc;
}
