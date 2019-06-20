Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8E5930C
	for <lists+linux-mmc@lfdr.de>; Fri, 28 Jun 2019 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF1Ex7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 28 Jun 2019 00:53:59 -0400
Received: from mail-pg1-f230.google.com ([209.85.215.230]:44224 "EHLO
        mail-pg1-f230.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF1Ex6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jun 2019 00:53:58 -0400
Received: by mail-pg1-f230.google.com with SMTP id n2so2014636pgp.11
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ctcd-edu.20150623.gappssmtp.com; s=20150623;
        h=from:subject:thread-topic:thread-index:date:message-id
         :accept-language:content-language:content-transfer-encoding
         :mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=yoeySuHZ2sejtG818TC1O/sRk49+/vQ3CbN+Cdo+UHW9L5funzQd2Q0pE2uLs0b0US
         3ooTACMRlY79vI4FLzqFZKHKKrxPTrXgXaWMcqe8jgbG9TaDTNtilkTZRtg6VlUGiKdp
         KbTF2mzomGYMgE4bQnu5VDh7bapfFBiT2qYBZJe7YG5LbyDWz/Eh/rPZUG+Ac0xjJxZH
         W3mbIfopUIqlT0EL+QWT7o/xSZm5JFZCL+eCmMMNv60Jnl/aFltkCdOXb5SlSsjXYCQB
         Nb4cLYVjYvOUfUwx9XO2NitclNXqBV9hkxd1YcPbhSzExvM/+lHPAma8+4zL50ilre/p
         2Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:thread-topic:thread-index:date
         :message-id:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=OmC1DCrVOFMD9aG4PpNhPk96Tb+9LblUH0eFFgSabDr7ycX9Cr7sYa2O8yH6HLhK7h
         vyHt48GPO6j2pfwNBwe5DeudEArM8bQ3aP8Qk9zXsihK7SRIqmJ8jFYXaBWtCg3J5uyP
         EFr3yqFemDIhqEaX9x0SEXoqqLx73Di8li4OgY/F18d9VKpFC1166F0FaMrWhapPV/Xj
         5s1KNTBeTF1y4dSJQOwO0IDas72KV5vQARXYlpiID6PssbimuqYVP70RZAN2llELa92Y
         V+qWzpJ1MBRNBjxu4fkLog/FhbQ8G4DC9rQKLFI5oLxDNr62xZZ1BJixfCR28H5j1n2S
         +rTw==
X-Gm-Message-State: APjAAAVXycRD8HC6piVnyra4SGxxcekIMybGkeajq7tJJqZjA9EypnAx
        NYr7vPxBrm9Yo6TwbYPZuMAo0DK3Fsp0HBgg/WD51X1wCoTsZg==
X-Google-Smtp-Source: APXvYqxJkYMp/D0/TOWa0cF+M2QrMgL6Fs/241l24lc+p+ZxC69PNEQYyCft/PgXL83TNevq6R0mSpDU13C7
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr10700090pjg.57.1561697638054;
        Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
Received: from mail.ctcd.edu (rrcs-67-79-90-89.sw.biz.rr.com. [67.79.90.89])
        by smtp-relay.gmail.com with ESMTPS id n69sm110753pjb.9.2019.06.27.21.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
X-Relaying-Domain: ctcd.edu
Received: from CTCEmail02.campus.ctcd.org (172.17.139.89) by
 CTCEmail01.campus.ctcd.org (172.17.139.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.845.34; Thu, 20 Jun 2019 09:20:21 -0500
Received: from CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800]) by
 CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800%2]) with mapi id
 15.01.0845.034; Thu, 20 Jun 2019 09:20:21 -0500
From:   "Chambers, Marcine" <MChambers@ctcd.edu>
Subject: GOOD DAY
Thread-Topic: GOOD DAY
Thread-Index: AQHVJ3NH8MyJd8SpTkSfWerfM/UxGQ==
Date:   Thu, 20 Jun 2019 14:20:21 +0000
Message-ID: <1bcebb25cbc54329a424613008b7d525@ctcd.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.139.254]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I am Vice Chairman of Hang Seng Bank, I have Important Matter to Discuss wi=
th you concerning my late client, Died without a NEXT OF KIN. Send me your =
private email for full details information. email me at (chienkraymond@outl=
ook.com)

Mail:infocarfer@aim.com

Regards
Dr.Raymond Chien Kuo Fung

