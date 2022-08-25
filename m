Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63B5A1A1C
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Aug 2022 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiHYUN4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Aug 2022 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiHYUNz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 16:13:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8942BFEA2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 13:13:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id bq23so20634848lfb.7
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=dI1VmNFiMljjIEyb8rkVr4fGpUcefvCbMk4RwwtTRTI=;
        b=G0IogqYosZHSOoeaNmpaJo0sUWyOIcqorzAOWBA+x+GT8+sIQ+rWfY5iAxgEPNC6Z7
         O7JneUqvBGy695FqpnE5y5YVl+xD5rYzSLZCAJDOg205Y/z0OcTMoYLhG2jpfRggzRGD
         +5vpd9zKn1dYCvc+aoQN8er+Mqq3hoLqkiJvg+L89NnZkQt9dZm1m2euFJxdKAovQg5D
         TCb296qghcTAfXUX8+T27r94ThAqg0TkHfpJTbSdgJYeMyBSln2GZAIn8wqOju8r6jir
         L3G8xUIVADC631Mw2fdIHjchGvlGTIqueyq276lv3ixX7anXXfmqBFCR3jHsF2RUtERm
         y1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=dI1VmNFiMljjIEyb8rkVr4fGpUcefvCbMk4RwwtTRTI=;
        b=fyOjHLejsI5RoJ8g4UJFLdjTxZIy9wAOBdiqbqJuUJqRLVU3bsiR/0I5Z1QwKHjtqY
         cdEkcmzTK7fS8gVPGQ8yXlSrMQH7L+L2/dlPOWSCFWkBi+tR6MlcdV2B534PY7EucS6d
         ZJbvtBezr7RM2sNL85aGT0HhC6NPJgCp4Kr8UtxQ+ZcToWlrJk6KJKE7dF7hOyGqNQOC
         4I7jSqRz4BUwfaYLSe7Uy2qg9KykHUHV79xxp2uIYI4HwgeAZFlxq9i1dOn+x8/5OKkG
         +PR3JnZmrVTFuZUU+J5fqZjgJ95ci4pjc2njHKfRO02sqgSWl2kVbETVTMzyxQTMNNdR
         RCOg==
X-Gm-Message-State: ACgBeo1wJyIyDfDVg3kwSTppxMFnu5aeTPV7SwuPwnS7D920WjO5xeJ/
        ymOi02NTs5g1mwa1qeQws5AYaOJNDSiCNI4tQ6A=
X-Google-Smtp-Source: AA6agR6Nv2D+tPvSHfQJNtDEayNBhmfPts8reeYCAUQaAtR1L1sZbIUrPBtABJO7RYyuCojalsa+X5DBvNtwDvvMZAU=
X-Received: by 2002:ac2:51af:0:b0:492:d9a5:82b8 with SMTP id
 f15-20020ac251af000000b00492d9a582b8mr1442790lfk.250.1661458433024; Thu, 25
 Aug 2022 13:13:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:51c1:b0:1dc:9997:314a with HTTP; Thu, 25 Aug 2022
 13:13:52 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. Sanon Abdoulaye" <sanonabdoulaye119@gmail.com>
Date:   Thu, 25 Aug 2022 13:13:52 -0700
Message-ID: <CAA6p7Uok1qs+bNs4tw3By47gv2ix2y3WE3zSk2v9dP7ky1D3+g@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:142 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7961]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sanonabdoulaye119[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sanonabdoulaye119[at]gmail.com]
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
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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
Mr. Sanon Abdoulaye
