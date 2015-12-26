module.exports = (app, connect, passport,config) ->

  FacebookStrategy = require('passport-facebook').Strategy
  TwitterStrategy = require('passport-twitter').Strategy
  passport.use(new FacebookStrategy({
    clientID: config.passport.facebook.clientID
    clientSecret: config.passport.facebook.clientSecret
    callbackURL: config.passport.facebook.callbackURL
    profileFields: ['displayName', 'id', 'email', 'gender', 'link', 'locale', 'name', 'timezone', 'updated_time', 'verified']
  },
  (accessToken, refreshToken, profile, done)->
    passport.session.accessToken = accessToken
    oauth_id = profile.id
    provider = profile.provider

    sql = "SELECT id,name,first_name,middle_name,last_name,photo FROM users WHERE oauth_id = '#{oauth_id}'  AND provider = '#{provider}'"
    connect.query sql,(err, results)->
      if !results[0]
        name = profile.displayName
        email = profile.emails[0].value
        gender = profile.gender
        locale = profile.locale
        last_name = profile.name.givenName
        first_name = profile.name.familyName
        middle_name = profile.name.middleName
        photo = "https://graph.facebook.com/#{oauth_id}/picture"
        post =
          provider: provider
          oauth_id: oauth_id
          name: name
          first_name: first_name
          middle_name: middle_name
          last_name: last_name
          mail: email
          photo: photo
          locale: locale
          gender: gender
        qur = connect.query "INSERT INTO users SET ?",post, (err, results)->
          user =
            user_name: name
            photo: photo
            first_name: first_name
            middle_name: middle_name
            last_name: last_name
          process.nextTick ()->
            done(null ,user)
      else
        user =
          user_name: results[0].name
          photo: results[0].photo
          first_name: results[0].first_name
          middle_name: results[0].middle_name
          last_name: results[0].last_name
        process.nextTick ()->
          done(null ,user)
  ))

  passport.use(new TwitterStrategy({
    consumerKey: config.passport.twitter.clientID
    consumerSecret: config.passport.twitter.clientSecret
    callbackURL: config.passport.twitter.callbackURL
  },
  (accessToken, refreshToken, profile, done)->
    oauth_id = profile.id
    provider = profile.provider
    sql = "SELECT id,name,first_name,middle_name,last_name,photo FROM users WHERE oauth_id = '#{oauth_id}'  AND provider = '#{provider}'"
    connect.query sql,(err, results)->
      if !results[0]
        name = profile.displayName
        locale = profile.location
        photo = profile.photos[0].value
        post =
          provider: provider
          oauth_id: oauth_id
          name: name
          photo: photo
          locale: locale
        qur = connect.query "INSERT INTO users SET ?",post, (err, results)->
          user =
            user_name: name
            photo: photo
          process.nextTick ()->
            done(null ,user)
      else
        user =
          user_name: results[0].name
          photo: results[0].photo
        process.nextTick ()->
          done(null ,user)
  ))
