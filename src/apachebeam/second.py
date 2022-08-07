import apache_beam as beam
import platform
import logging
import argparse
from typing import List, Optional
from apache_beam.options.pipeline_options import PipelineOptions, SetupOptions
from utils.common_functions import split_input

class AppOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_value_provider_argument('--header')
        parser.add_value_provider_argument('--output')


def run(beam_args: List[str] = None):

    options = PipelineOptions(beam_args)
    setup_options = options.view_as(SetupOptions)
    app_options = options.view_as(AppOptions)

    with beam.Pipeline(argv=beam_args) as p:
        lines = (
                p
                | beam.Create(["Hello", "World!", platform.platform()])
        )

        lines | beam.Map(print)

if __name__ == "__main__":
    logging.getLogger().setLevel(logging.WARNING)

    parser = argparse.ArgumentParser()
    args, beam_args = parser.parse_known_args()

    run(beam_args=beam_args)
