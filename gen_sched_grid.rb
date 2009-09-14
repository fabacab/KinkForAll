#
##
### This script generates an hCalendar as an HTML table to archive a KinkForAll
### event's Schedule Grid. The resultant markup should be placed on the wiki
### at http://wiki.KinkForAll.org/KinkForAll#{EVENT_LOCALE}Schedule
##
#

### @see http://wiki.KinkForAll.org/KinkForAllLocationSchedule
### @file gen_sched_grid.rb
### @licsense GPL3
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
###

require 'date'

EVENT_LOCALE='Boston'
NUM_LOC = 4 # number of locations
EVENT_START=DateTime.parse('2009-09-12T10:40:00-04:00')
EVENT_END=DateTime.parse('2009-09-12T17:00:00-04:00')
LUNCH_START=DateTime.parse('2009-09-12T12:21:00-04:00')
LUNCH_END=DateTime.parse('2009-09-12T13:20:00-04:00')
STEP=20/(24*60).to_f # length in minutes over minutes in a day

puts <<XXX
<table width="100%" cellspacing="1" cellpadding="1" class="pbNotSortable vcalendar" summary="KinkForAll #{EVENT_LOCALE} Schedule Grid">
    <thead>
        <tr>
            <td>&nbsp;</td>
            <th axis="location" id="location-1"><strong>Main Room</strong></th>
            <th axis="location" id="location-2"><strong>Conference Room</strong></th>
            <th axis="location" id="location-3"><strong>Nook</strong></th>
            <th axis="location" id="location-4"><strong>Alt Space</strong></th>
        </tr>
    </thead>
    <tbody>
XXX

i = 0
(EVENT_START).step(EVENT_END, STEP) do |t|
  # don't generate slots during lunch
  next if t > LUNCH_START and t < LUNCH_END

  i += 1
  t_e = t + STEP
  puts <<XXX
        <tr>
            <th axis="time" id="time-#{i}"><strong><abbr title="#{t.strftime}" class="dtstart">#{t.strftime("%I:%M %p")}</abbr></strong> &ndash; <abbr title="#{t_e.strftime}" class="dtend">#{t_e.strftime("%I:%M %p")}</abbr></th>
XXX
  NUM_LOC.times do |l|
    l+=1
    puts <<XXX
            <td headers="time-#{i} location-#{l}" class="vevent"></td>
XXX
  end
  puts <<XXX
        </tr>
XXX
end

puts <<XXX
    </tbody>
</table>
XXX
