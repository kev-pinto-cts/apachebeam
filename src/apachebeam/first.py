import apache_beam as beam
import logging
import argparse
from utils.common_functions import split_input


def run(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--input")
    parser.add_argument("--output")
    args, beam_args = parser.parse_known_args(argv)
    with beam.Pipeline(argv=beam_args) as p:
        lines = (
                p
                | "Read File" >> beam.io.ReadFromText(args.input, skip_header_lines=1)
                | "Split Lines" >> beam.Map(split_input)
                | "Print" >> beam.Map(print)
                )



if __name__ == "__main__":
    logging.getLogger().setLevel(logging.WARNING)
    run()
