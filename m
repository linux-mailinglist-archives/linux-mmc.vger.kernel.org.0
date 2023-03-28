Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8996CC1CE
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Mar 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjC1OOi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 Mar 2023 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjC1OOg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2023 10:14:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5183F6
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2023 07:14:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s20so12724780ljp.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2023 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012853;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb4LYTz6ltLsND5GCzIBKn5H+VpjQGr9vlRB0NuV50c=;
        b=pCc81/lsXn1xrmyeQVw7IGEXamYtSQf7TCG/HepPsA9U+GiMcyFZG+W3/HoeqqH4oU
         k/m/jYkRWKf+oTHA7ZFzcrUf9zySoSX4SLxXj1eWZoRyIXJzTSU+P4lgkn/Vl/lpzuiq
         x9sR5VJ4cIeIpImrHNdDSfYI2xTV1aP1WZHCfglCyc093h9wX53mM/2vMy6Sy0GoFlRE
         IwJBgAUbLzsg0LIix9Zd99StcLlmxsa5TGFA4ZmArnPCevMWvLWfab12KEYfC2Pss7Qi
         yNnsHmeX6RY22OKLg79tZweR39uy95ycoZAhrQyF5M8EIwurUlINIV93IJBQd/Hkoe67
         EdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012853;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mb4LYTz6ltLsND5GCzIBKn5H+VpjQGr9vlRB0NuV50c=;
        b=q1uFRmzzVLFqOH7b5U+wSdhi91MCx2YR6/kFqx2IIhSfOA4t5n2KADn6IC+ppIctig
         D+YNpi4cPdkYuM5JGBTVTCOLgsdcbFQ+kUkd+YT6v9+GMsqOMCObHy2uqzBCvHZnMqqZ
         +dkbiPTPdDHkGogojhLY8l0MXd+yZ6gIa9DzQmhJwhDBQup6NCXTD0RzKNu4UMt6LEUi
         wHKemxaY5PPVM/wOj5L43JQMAviNjLTX315CjmoIcobfwKxcfgCKk/ZnMyDVOHIi4rgw
         IAFYo282L3Iv2DVSI4CboEEH5xvalbQGw3xK+Oye8r4F+AK0/Y8bKANad2M7duZ6unJg
         P+Cw==
X-Gm-Message-State: AAQBX9dihR3BEqx5RbkzMJ5D/yIwBJEiEKzyO79zfUCu8DwnN37WRasm
        LF7SiKTmTDeQfNh3wyhRkL57fxWy8dN+dRn3kq4=
X-Google-Smtp-Source: AKy350aLi4y5oeLUIIiiG/MEIMo7nSP7/nmuaHETV+Xn4hsoVUbLQysTMlJ7iBJBdAiPNgrejgGkqarGVsB0N/dnZ4Y=
X-Received: by 2002:a2e:8702:0:b0:295:acc0:3017 with SMTP id
 m2-20020a2e8702000000b00295acc03017mr4690403lji.4.1680012853033; Tue, 28 Mar
 2023 07:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8e84:0:b0:290:4f29:1dd5 with HTTP; Tue, 28 Mar 2023
 07:14:12 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <osasgoodness8@gmail.com>
Date:   Tue, 28 Mar 2023 06:14:12 -0800
Message-ID: <CANczi2zWDR1ScFZY00wNqcbjxYdmxmWQKj2GnyvGNLxu4ng9cw@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Dear,

My name is Lily William, I am from the United States of America
presently living in the UK, Its my pleasure to contact you for new and
special friendship I will be glad to see your reply for us to know
each other better.

Yours
Lily
