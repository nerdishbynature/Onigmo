SHA=$(shell git rev-parse HEAD)
BRANCH=$(shell git name-rev --name-only HEAD)

install:
	gem install slather fastlane

test:
	cd Carthage/Checkouts/Onigmo && ./configure
	fastlane code_coverage configuration:Debug --env default

post_coverage:
	slather coverage --input-format profdata -x --ignore "../**/*/Xcode*" --ignore "Carthage/**" --output-directory slather-report --scheme Onigmo Onigmo.xcodeproj
	curl -X POST -d @slather-report/cobertura.xml "https://codecov.io/upload/v2?token="$(CODECOV_TOKEN)"&commit="$(SHA)"&branch="$(BRANCH)"&job="$(TRAVIS_BUILD_NUMBER)

