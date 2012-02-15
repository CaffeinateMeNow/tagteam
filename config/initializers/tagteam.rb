ROBOT_USER_AGENT = "tagteam social RSS aggregrator 0.1: http://github.com/berkmancenter/taghub"
RSS_GENERATOR = "tagteam social RSS aggregrator"

# If a feed has changed, schedule it to be spidered again within this interval.
MINIMUM_FEED_SPIDER_INTERVAL = 30.minutes

# If a feed has not changed within this interval, back off for SPIDER_DECAY_INTERVAL. This is set to 6 hours to 
# ensure we don't entirely forget that a feed is busy over night.
SPIDER_UPDATE_DECAY = 6.hours

# After SPIDER_UPDATE_DECAY has been reached, extend the next spidering event out by this interval.

SPIDER_DECAY_INTERVAL = 1.hour

MAXIMUM_FEED_SPIDER_INTERVAL = 1.day

DEFAULT_TAGTEAM_PER_PAGE = 25

Resque.redis.namespace = "resque:TagTeam"

require File.dirname(__FILE__) + '/../../lib/will_paginate/view_helpers/custom_link_renderer.rb'

