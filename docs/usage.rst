Usage
=====

.. _basic:

Basic
-----

Register new user on Mattermost. Copy email/password/team and url into ``mmpy_bot_settings.py`` file::

    BOT_URL = 'http://<mm.example.com>/api/v4'  # with 'http://' and with '/api/v4' path
    BOT_LOGIN = '<bot-email-address>'
    BOT_PASSWORD = '<bot-password>'
    BOT_TEAM = '<your-team>'



Run the bot::

    $ MATTERMOST_BOT_SETTINGS_MODULE=mmpy_bot_settings matterbot


Structuting Your Basic Bot with Plugins
---------------------------------------

If you simply want to add some plugins ( listen_to, respond_to handlers), 
you can have bot code files orginized under ``/opt/your_bot/`` like this :

::

    ~/opt/your_bot/
        my_plugins/
            __init__.py
            intro.py
            <more py modules>
        mmpy_bot_settings.py

Where the ``intro.py`` is a handler module.


Integration with Django
-----------------------

Create bot_settings on your project and after you can create ``django`` command::

    import logging
    import sys

    from django.core.management.base import BaseCommand
    from django.conf import settings

    from mmpy_bot import bot, settings


    class Command(BaseCommand):

        def handle(self, **options):

            logging.basicConfig(**{
                'format': '[%(asctime)s] %(message)s',
                'datefmt': '%m/%d/%Y %H:%M:%S',
                'level': logging.DEBUG if settings.DEBUG else logging.INFO,
                'stream': sys.stdout,
            })

            try:
                b = bot.Bot()
                b.run()
            except KeyboardInterrupt:
                pass


Modify ``manage.py``::

    #!/usr/bin/env python

    import os
    import sys


    if __name__ == "__main__":
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.settings")
        os.environ.setdefault("MATTERMOST_BOT_SETTINGS_MODULE", "project.mmpy_bot_settings")

        from django.core.management import execute_from_command_line

        execute_from_command_line(sys.argv)
