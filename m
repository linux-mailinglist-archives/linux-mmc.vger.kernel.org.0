Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEF6516AE
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Dec 2022 00:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiLSXRa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Dec 2022 18:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiLSXQ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 18:16:59 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FD113
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 15:13:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id jr11so9674638qtb.7
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 15:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=YOsO7P5J9PsTryCKeQw+GYlHvOyafXZ1l5IrllyX5QN5LlCaL1YPRvnhznsC7e3Y9/
         +fJWcPZ5oHCvoOnZ/xSBHTa6tcDnLgqoaJ3gpxRtXboSlIQcQ/xe2QFn8DXKM7/o2lXD
         XUZpVxMhIE+Vpg++2UtjfoXes5lJS/wcwzdRvpeJKYLTA6gcpeJDGFsLoEVWAB0nnqS+
         JWXdcWrixiPUxoCoNLwqvNIdm5m7kSGflrhyExg+NSdC+oCh6J3pvlemj3118AP5HTUZ
         T4YtnepbZjYfIj8otXt88YQQq7SEc3/k6heHmxlcq1mvk3pUCN3keV9FrKXFOTLOVwCN
         mfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=NYKmVRjuDGK2hm/7GgCTGKD+c+vQvJJ8M77RD1QuSBqIiTP+yoHpc4XCCGSYa4/4gz
         p3yPzl4rWS897eJcNhmm7FYxqP82ByfpMLneERgYySLD7dib5z/n/P9j4NthTla5aiih
         U3g50NFHEDZB+ij4kG+WoYfyFaw2QJSis7vTVdxfZMxNLtY3muAxyGWcmyiysRLQ2wRv
         eK5eW68hvjLJGLT6fCdx0xNKZIfAmKxPDEngM7xphIdtHVpmJ4Wq1a0lC2bbvG97CAcn
         wiLWZobKNNoQWPRwX5/ypogP3oIXtpMFu+j35ieaJvowexEFfYbsPTXXsC0k1QbtmGIO
         B5qQ==
X-Gm-Message-State: ANoB5plHPcJCjC9e4ozaUx3KuBn/mQxcBfUUAfnRq8Ht2xQ9u2d6sbz4
        oqN8uwIqfRwjDsEN4GpND+zX43whdwR3uEiBLQY=
X-Google-Smtp-Source: AA0mqf6WySW3DNBKo8LQOUcdl+SfoG+csTx3bumT3G0r0wiUK5ESV0owMM8zJWnr7tn05QBfDlckBayxF03figlSJxI=
X-Received: by 2002:a05:622a:260a:b0:3a8:1538:442f with SMTP id
 ci10-20020a05622a260a00b003a81538442fmr1613143qtb.443.1671491596655; Mon, 19
 Dec 2022 15:13:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:ec85:0:b0:4c7:809b:ab67 with HTTP; Mon, 19 Dec 2022
 15:13:16 -0800 (PST)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <xmlcsu@gmail.com>
Date:   Mon, 19 Dec 2022 15:13:16 -0800
Message-ID: <CAB5xSQWAV7c+vftmQ=9vHcN=GgBmxYhrpdyFsL1g=GYObFLOMA@mail.gmail.com>
Subject: Reply and let me know if you received this email...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
