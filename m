Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED45A19A0
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Aug 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbiHYThq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Aug 2022 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYThp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 15:37:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF6BC824
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:37:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f21so21276830pjt.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o2rScCjvXVxWvz35qYLyGk2pLCsnGqfLECgC0wg1Bvk=;
        b=OGDzsLTosjK/nvp5k20NvGX5rVvDP+feh6l/tj8LohiG/c8QgegfY3ULkFTVexP+Mw
         OGn3yW/xdYyOqhb4j0bCbvLZDLv+FapO4wlFKwEg4ruGv2wRVSrTk3Y7pABcjH1PAeir
         Z8MoSVuJ2KwlxJ7F6/nX4z1QsaxNyP5uvtlgy/tAMxW1ucxVzCbGtRj3Fx30FZGkfcki
         KHNbNK2BQYwbPETJp+OENOgMpka5Wrg3j3fIfgXvoEYUjwHB49yuslZfWl3O6gIIJqRr
         dG1ix7npn+EsEARRrsscTkRKrtKimRdfWGMQXfVUul7abQZYWfnAK7T3bCj7YvtnC3zZ
         np6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o2rScCjvXVxWvz35qYLyGk2pLCsnGqfLECgC0wg1Bvk=;
        b=6Jn41u/M/AhcrKWA5c7zR0QPHKTfTPT+25/RhETX8LnQ92XVD8KRy/53fo/otNFxdW
         YPXPJYISTNqeQ2mlpu7v809AboadCSQHalgDICu4OXgE8Kn9s5IPJYrBdhF6hyTe2OAK
         bRLXqU+2aiqLCgjhmhLhvcgXWNMMPxZGvpsKbP32I5uT5d+S5HwUTlMmPM8KVN+wLyc1
         G3+8F4oBlAO3Y/i8luEA+pnA+C1ccET8tk3mFjdGorIpef3OcAxOrmXCg06tvL0ojSvR
         JN5X38khn0KOQlgUYeWX80YXGxhVW2HeIHluOLZIN9eJR4aDAIQLgszqkGiqH1Z6x0NO
         uGSg==
X-Gm-Message-State: ACgBeo305cC0MfiTVaiLQyhYowdW/RQ11z36qqJmibzI4OL3HuB+SVdG
        nwjRIZViYUny2q4pM4bovN25tx3utobcFn/HwgI=
X-Google-Smtp-Source: AA6agR5W0HsIQH0u6rhe0ioEyuqVdVnZFQDGq097qXb1OEm5e/+EXwhH/3KxJcie4fefFW6K3d0rM9VfNHlsf2M3EeY=
X-Received: by 2002:a17:903:248:b0:172:7520:db04 with SMTP id
 j8-20020a170903024800b001727520db04mr472193plh.99.1661456264213; Thu, 25 Aug
 2022 12:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:cb83:b0:462:814f:9818 with HTTP; Thu, 25 Aug 2022
 12:37:43 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <poolcatfish@gmail.com>
Date:   Thu, 25 Aug 2022 12:37:43 -0700
Message-ID: <CADP_pte5Oxm2kuHa5auK9T3k1nb87B=L7_bfg2HeJhKSLCxdqg@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [poolcatfish[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
The Board Directors want to know if you are in good health doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
