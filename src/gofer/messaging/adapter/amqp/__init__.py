# Copyright (c) 2013 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.


from gofer.messaging.adapter.amqp.model import Exchange, Queue
from gofer.messaging.adapter.amqp.connection import Connection
from gofer.messaging.adapter.amqp.consumer import Reader
from gofer.messaging.adapter.amqp.producer import Sender


PROVIDES = [
    'amqp-0-9-1',
    'rabbitmq',
    'rabbit',
]