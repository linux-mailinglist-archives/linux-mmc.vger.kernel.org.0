Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82798542F86
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Jun 2022 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiFHL5n (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Jun 2022 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiFHL5m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 07:57:42 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569333AA57
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 04:57:40 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id n203so1590308vke.7
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=RqvhwLxpoWsPOdPHLQ+kBu2OEWvgdFg9DMc+/a8ko9E=;
        b=VOSoC8T7R4zExXwbHDP8cJk6USbdWqGuhT3FRbCISv70RfEUkp5fuVXTzZtO4TwLwH
         w3cJLuxX2z6Y9WDLtLPZfefmjdwuekbMLVZfTx/vhk3+dFoNUW1jXp8Olt6NC+Z0X+d2
         xX90cP45Bv/2E1FL9gX+v/IGzIY5CpJWVu4xNAT+fKgdjHYcC4gs5vkjLj6T590EqrvS
         NgiuJvHkSV5id/N1TZ0jAtprKfg+IIBVO/7pDjAltof0zOG1kdeBeZpwqA2G0mpZXcRP
         /MdaG9R65hfe5xjUfYrl11cCyPkTxW5xB2WNSZQvIGQWp5c3QDL2kGx57sC4pyHm6gqM
         vBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=RqvhwLxpoWsPOdPHLQ+kBu2OEWvgdFg9DMc+/a8ko9E=;
        b=PBu4ly4s+6mg9/REnvHCQ50bIVk2Xsj6XqSkez0z7C87FD3NSFnkTWWBlh5U1IOmF1
         fR9BPlbs9zNADXKe7fJLFhFrZtJo6qUao4XIZ5uHCpYz2IAv1gecRiP3ofJQd+y8Nsqp
         yVPYnzBkLMu+0V/G7KDkEPhhiGqNHyoiicCHbtBZg65cdbYIRNo2gggSAK87k+yO4hZx
         d7YSoObkxt9GmoXtoYkPysdZnBYJvF+duvNbEJYy7Z69+AKLXi+qTjs+K/W5eXvLxskE
         gES1MMdhRftzCkMnMR6i1bKTqbCbhDXLoC6Kb/70yPlmjj+jMOQI/L4ls9LVw++5rbvw
         msrA==
X-Gm-Message-State: AOAM531G7F+J+A9s7HuLPdDNW1fuLIn+jNurve8mJlhLnDC5juDxuBqo
        6oxlkazPwvZO72ghyqD7jtteg2ynT7uJn+j2K2o=
X-Google-Smtp-Source: ABdhPJwhXs4LTQIz5wU5bEKs4qkrvQesa4rhnYrO5eUnbJhmy1IrDTjmA4g2r8cQa7LD0WPUOU2iDfFAC1sX29d+iZw=
X-Received: by 2002:ac5:c902:0:b0:35d:aee2:dc50 with SMTP id
 t2-20020ac5c902000000b0035daee2dc50mr8746117vkl.23.1654689458534; Wed, 08 Jun
 2022 04:57:38 -0700 (PDT)
MIME-Version: 1.0
Sender: ceciliajosephallan@gmail.com
Received: by 2002:a05:612c:78a:b0:2c5:1b92:cec with HTTP; Wed, 8 Jun 2022
 04:57:37 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Wed, 8 Jun 2022 13:57:37 +0200
X-Google-Sender-Auth: R_KEHA93MkSJm4fGk7pATVk24x8
Message-ID: <CAMGypkNH=qjyVQ_FVUY+WwkYFXoJQmSnKG3gZ0xNyYJNhGzwKw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of( Eleven
Million Dollars) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
