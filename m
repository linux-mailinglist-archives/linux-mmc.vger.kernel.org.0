Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C94D6F7E
	for <lists+linux-mmc@lfdr.de>; Sat, 12 Mar 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiCLOTd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 12 Mar 2022 09:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCLOTd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2022 09:19:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DC60A9E
        for <linux-mmc@vger.kernel.org>; Sat, 12 Mar 2022 06:18:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z4so9864518pgh.12
        for <linux-mmc@vger.kernel.org>; Sat, 12 Mar 2022 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=Eds3pG3PtyHx2k5vzsNoawXBu9sk7upVDedSCoYYWwaDlojzz9kHIVjrGJPl9ImKcB
         bXHmCDL9MYr3aCbSXVRCYStQA/ez8BTo5TrSPW/oGW/UCeS0Q6JSvm5iEwuzU2d+Cn0m
         nNOfpCOaHAyK1x0/sO71D7Cye4W8glsHwQLTWvpShOne8FC5XroTFuAO5JEwuYn9pNXZ
         g3XkkBd1W9fxO1sPTLEuVm2geS3QZRKUp0PO6YLNqZavwLAFdHH5NPGRUglSE76Gc2LS
         3PhYViepCb/uKTZO79dBm1SxkEYSu0vi/+GL/MmFV10aUta6y+2cec0Sti+yLPa5Tl6j
         ch/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=Y4PS94OaFFf4V5XFAd7pb1tuuv9Zjoh55P0N/nXu/z5m55DMuEVLoJIjDvVHFQkkXT
         WRoKNPYGdbtjAbCySmIi44PdLwrxOED6BHCiKHx/UaYRBAkf6xl+RePl2VuPn88yKDAf
         eGyiB9jUynIsidvOzeMN0HZdPXAcDeWn9o4nVNgGMcmLc0f+TIa7zs2M1n3R4hFOS70g
         MySlUZ/oNfK47Q6GN/t/BLU2WKyUd9CAEw+1q7/luNHpzu3mYhBh8LyDXfnfeAdnLOpM
         mPp+FZkhxy1PvXvOpnFKjsCfpNUhiE8f1thQRw2DVFxywr2Yhivin0wEc2/YPITRSz76
         YsGA==
X-Gm-Message-State: AOAM533nM1sokkTdP/tg57+X8LS//+gjCVeP7zyWVbfZg3/yVYwjyfo+
        R2F4Bq7VK692oWYdOihXKHIlpzuly9ZeESkrCkA=
X-Google-Smtp-Source: ABdhPJxKUJxvFBwuCRvE4XscNZhJsCXAgIOBvuHYQNoGeUw3l8wx90eQhDuhumMhW1flQ0CvFYPl4pgTqv+5hQzqUBQ=
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id
 c16-20020a056a000ad000b004f7a3576899mr3974060pfl.80.1647094705754; Sat, 12
 Mar 2022 06:18:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:43d2:0:0:0:0 with HTTP; Sat, 12 Mar 2022 06:18:25
 -0800 (PST)
From:   serge amidal <sergeamidal3@gmail.com>
Date:   Sat, 12 Mar 2022 06:18:25 -0800
Message-ID: <CAO5SrQmC8=j8kgGCcUPdsTo6+1T4Y5B2ah9u0rKNu0697-AGXQ@mail.gmail.com>
Subject: message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello
 I need your urgent help to transfer an abandoned fund
to your account within 10-14 days if you are interested, reply to me
with your information for more details. your first and last name: -. Your
the country:-. your phone number. : -.
 Please reply to this email address (sergeamidal@gmail.com)
 Best regards
Amidal Serge
